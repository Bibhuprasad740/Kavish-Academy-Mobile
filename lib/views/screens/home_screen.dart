import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kavish_academy/constants/utils.dart';
import 'package:kavish_academy/constants/variables.dart';
import 'package:kavish_academy/controllers/map_controller.dart';
import 'package:kavish_academy/models/address_model.dart';
import 'package:kavish_academy/views/widgets/address_tile.dart';
import 'package:kavish_academy/views/widgets/custom_textfield.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../constants/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _desinationLocationController =
      TextEditingController();
  GoogleMapController? newController;
  AddressModel? searchResult;

  @override
  void dispose() {
    super.dispose();
    _desinationLocationController.dispose();
  }

  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    await Variables.fbsController.setUserData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            Variables.mapController.isLoading.value
                ? const LoadingIndicator(indicatorType: Indicator.ballPulse)
                : GoogleMap(
                    buildingsEnabled: true,
                    myLocationEnabled: true,
                    mapType: Variables.mapController.mapType.value,
                    trafficEnabled: true,
                    zoomControlsEnabled: true,
                    zoomGesturesEnabled: true,
                    padding: EdgeInsets.only(
                      bottom: size.height * 0.4,
                      top: 20,
                    ),
                    initialCameraPosition:
                        Variables.mapController.currentPosition.value,
                    onMapCreated: (GoogleMapController controller) async {
                      Variables.mapController.googleMapController
                          .complete(controller);
                      newController = controller;
                      await Variables.mapController.getCurrentLocation();
                      // await Variables.mapController.changeMapTheme();
                      await Variables.fbsController.setUserData();
                      setState(() {});
                    },
                    markers: {
                      Marker(
                        markerId: const MarkerId('Source'),
                        position: LatLng(
                          MapController().position.latitude,
                          MapController().position.longitude,
                        ),
                      ),
                    },
                  ),
            // : Container(
            //     alignment: Alignment.center,
            //     height: size.height,
            //     width: double.infinity,
            //     child: FirebaseStorageController().isLoading.value
            //         ? CircularProgressIndicator()
            //         : Text(
            //             'Hi ${Variables.fbsController.firebaseUserData.value.name}'),
            //   ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: size.height * 0.4,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Hi ',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontSize: 16,
                                    ),
                                  ),
                                  TextSpan(
                                    text: Variables.fbsController
                                        .firebaseUserData.value.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 18,
                                      color: GlobalColors.accent1,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color:
                                          GlobalColors.accent3.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: IconButton(
                                    onPressed: () async {
                                      await Variables.mapController
                                          .changeMapType(context);
                                      setState(() {});
                                    },
                                    icon: const Icon(
                                      Icons.auto_stories,
                                      color: GlobalColors.accent1,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Select your destination',
                          style:
                              TextStyle(fontSize: 20, fontFamily: "Brand-Bold"),
                        ),
                        const SizedBox(height: 20),
                        Variables.mapController.isLoading.value == true
                            ? const Center(
                                child: SizedBox(
                                  height: 30,
                                  child: LoadingIndicator(
                                    indicatorType: Indicator.ballPulse,
                                  ),
                                ),
                              )
                            : Row(
                                children: [
                                  const Icon(Icons.my_location),
                                  const SizedBox(width: 10),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'From  ',
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                        ),
                                        TextSpan(
                                          text: Variables
                                              .mapController.userAddress.value,
                                          style: const TextStyle(
                                              color: GlobalColors.accent1,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              fontFamily: 'Brand-Bold'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          onChanged: (value) async {
                            searchResult = await Variables.mapController
                                .searchResults(value);
                            setState(() {});
                          },
                          textEditingController: _desinationLocationController,
                          hintText: 'Where you want to go?',
                        ),
                        searchResult == null
                            ? Container()
                            : ListView.builder(
                                shrinkWrap: true,
                                itemBuilder: (context, index) => AddressTile(
                                  address: searchResult!,
                                  onTap: () {
                                    Utils.showToast(
                                      context: context,
                                      message: 'Booyoo!!',
                                    );
                                  },
                                ),
                                itemCount: 1,
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kavish_academy/controllers/auth_controller.dart';
import 'package:kavish_academy/controllers/map_controller.dart';
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
  final mapController = MapController.instance;

  @override
  void dispose() {
    super.dispose();
    _desinationLocationController.dispose();
  }

  @override
  void initState() {
    addData();
    super.initState();
  }

  Future<void> addData() async {
    await MapController().getCurrentLocation().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    User? user = AuthController.instance.getUser;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            MapController().isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : GoogleMap(
                    buildingsEnabled: true,
                    myLocationEnabled: true,
                    mapType: mapController.mapType.value,
                    trafficEnabled: true,
                    zoomControlsEnabled: true,
                    zoomGesturesEnabled: true,
                    padding: EdgeInsets.only(
                      bottom: size.height * 0.4,
                      top: 20,
                    ),
                    initialCameraPosition: mapController.currentPosition.value,
                    onMapCreated: (GoogleMapController controller) async {
                      mapController.googleMapController.complete(controller);
                      await mapController.getCurrentLocation();
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
            //     child: Text('Hi ${user!.uid}'),
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
                            const Text(
                              'Hi There!',
                              style: TextStyle(fontSize: 15),
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
                                      await mapController
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
                        mapController.isLoading.value == true
                            ? Center(
                                child: SizedBox(
                                  height: 30,
                                  child: const LoadingIndicator(
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
                                          text: mapController.userAddress.value,
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
                          textEditingController: _desinationLocationController,
                          hintText: 'Where you want to go?',
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

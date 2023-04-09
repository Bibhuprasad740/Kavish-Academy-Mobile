import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kavish_academy/constants/utils.dart';
import 'package:kavish_academy/constants/variables.dart';
import 'package:kavish_academy/views/widgets/custom_textfield.dart';

import '../../constants/colors.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _googleMapController =
      Completer<GoogleMapController>();
  Position? position;
  CameraPosition currentPosition = Variables.initialCam;
  final TextEditingController _desinationLocationController =
      TextEditingController();
  Completer<GoogleMapController> _completer = Completer();
  GoogleMapController? _mapController;
  final geoCodingPlatform = GeocodingPlatform.instance;
  List<Placemark> userAddress = [];
  var mapType = MapType.normal;

  @override
  void dispose() {
    super.dispose();
    _desinationLocationController.dispose();
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  Future<void> getCurrentLocation() async {
    Position? pos = await Utils.getCurrentLocation();
    position = pos;
    setState(() {});
    LatLng latLng = LatLng(position!.latitude, position!.longitude);
    currentPosition = CameraPosition(
      target: latLng,
      zoom: 16,
    );
    _mapController = await _googleMapController.future;
    _mapController!.animateCamera(
      CameraUpdate.newCameraPosition(currentPosition),
    );
    var address = await geoCodingPlatform.placemarkFromCoordinates(
        pos!.latitude, pos.longitude);
    userAddress = address;

    setState(() {});
  }

  void changeMapType() {
    if (mapType == MapType.normal) {
      mapType = MapType.hybrid;
    } else {
      mapType = MapType.normal;
    }
    print(mapType.toString());
    setState(() {});
  }

  // void locatePos() async

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          position == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : GoogleMap(
                  buildingsEnabled: true,
                  myLocationEnabled: true,
                  mapType: mapType,
                  trafficEnabled: true,
                  zoomControlsEnabled: true,
                  zoomGesturesEnabled: true,
                  padding: EdgeInsets.only(
                    bottom: size.height * 0.4,
                    top: 20,
                  ),
                  initialCameraPosition: currentPosition,
                  onMapCreated: (GoogleMapController controller) async {
                    _googleMapController.complete(controller);
                    await getCurrentLocation();
                    setState(() {});
                  },
                  markers: {
                    Marker(
                      markerId: const MarkerId('Source'),
                      position: LatLng(
                        position!.latitude,
                        position!.longitude,
                      ),
                    ),
                  },
                ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Hi There!',
                            style: TextStyle(fontSize: 15),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: GlobalColors.accent3.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10)),
                            child: IconButton(
                              onPressed: changeMapType,
                              icon: Icon(
                                Icons.cameraswitch,
                                color: GlobalColors.accent1,
                              ),
                            ),
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
                      userAddress.isEmpty
                          ? CircularProgressIndicator()
                          : Row(
                              children: [
                                Icon(Icons.my_location),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('From ${userAddress.first.locality}')
                                  ],
                                )
                              ],
                            ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        textEditingController: _desinationLocationController,
                        hintText: 'Search a place',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

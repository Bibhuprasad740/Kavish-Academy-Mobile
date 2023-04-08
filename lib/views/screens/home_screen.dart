import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kavish_academy/constants/utils.dart';
import 'package:kavish_academy/constants/variables.dart';
import 'package:kavish_academy/views/widgets/custom_textfield.dart';

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

  @override
  void dispose() {
    super.dispose();
    _desinationLocationController.dispose();
  }

  @override
  void initState() {
    getCurrentPosition();
    super.initState();
  }

  Future<void> getCurrentPosition() async {
    Position? pos = await Utils.getCurrentLocation();
    print(pos);
    setState(() {
      position = pos;
      currentPosition = CameraPosition(
        target: LatLng(
          pos!.latitude,
          pos.longitude,
        ),
        zoom: 18,
      );
    });
  }

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
                  mapType: MapType.hybrid,
                  trafficEnabled: true,
                  padding: const EdgeInsets.all(10),
                  initialCameraPosition: currentPosition,
                  onMapCreated: (GoogleMapController controller) =>
                      _googleMapController.complete(controller),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      'Hi There!',
                      style: TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Select your destination',
                      style: TextStyle(fontSize: 20, fontFamily: "Brand-Bold"),
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      children: [
                        Icon(Icons.my_location),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [Text('From Your Current Address')],
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
        ],
      ),
    );
  }
}

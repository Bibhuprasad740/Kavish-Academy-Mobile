// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kavish_academy/controllers/firebase_storage_controller.dart';
import 'package:kavish_academy/models/address_model.dart';

import '../constants/utils.dart';
import '../constants/variables.dart';

class MapController extends GetxController {
  static MapController instance = Get.find();

  final Completer<GoogleMapController> googleMapController =
      Completer<GoogleMapController>();
  Position position = Variables.defaultLocation;
  Rx<CameraPosition> currentPosition = Variables.initialCam.obs;
  GoogleMapController? _mapController;
  final geoCodingPlatform = GeocodingPlatform.instance;
  var userAddress = ''.obs;
  var mapType = MapType.normal.obs;
  Rx<bool> isLoading = false.obs;

  Future<void> getCurrentLocation() async {
    isLoading.value = true;
    try {
      Position? pos = await Utils.getCurrentLocation();
      position = pos!;
      LatLng latLng = LatLng(position.latitude, position.longitude);
      currentPosition.value = CameraPosition(
        target: latLng,
        zoom: 16,
      );
      var address = await geoCodingPlatform.placemarkFromCoordinates(
          pos.latitude, pos.longitude);
      userAddress.value += '${address.first.name}, ';
      userAddress.value += '${address.first.locality}, ';
      userAddress.value += '${address.first.postalCode}, ';
      userAddress.value += address.first.isoCountryCode.toString();

      _mapController = await googleMapController.future;
      await _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(currentPosition.value),
      );
    } catch (e) {
      Get.snackbar(
          'Something went wrong!', 'Please try again after some time!');
      debugPrint(
        'Catch block in MapController.getCurrentLocation(), ${e.toString()}',
      );
    }
    isLoading.value = false;
  }

  Future<void> changeMapType(BuildContext context) async {
    isLoading.value = true;
    bool isPlusMember = await FirebaseStorageController().checkPlusMember();
    if (isPlusMember) {
      if (mapType.value == MapType.normal) {
        mapType.value = MapType.hybrid;
        Utils.showToast(context: context, message: 'Enabled Satelite mode');
      } else {
        mapType.value = MapType.normal;
        Utils.showToast(context: context, message: 'Disabled Satelite mode');
      }
    } else {
      Utils.showToast(
          context: context, message: 'Satelite view is only for Plus Members!');
    }
    isLoading.value = false;
  }

  Future<AddressModel?> searchResults(String address) async {
    AddressModel? foundAddress;
    if (address.length > 1) {
      try {
        var fetchedData = await geoCodingPlatform.locationFromAddress(
          address,
          localeIdentifier: 'en_IN',
        );
        var result = await geoCodingPlatform.placemarkFromCoordinates(
          fetchedData[0].latitude,
          fetchedData[0].longitude,
        );
        print(result);
        if (result.isNotEmpty) {
          foundAddress = AddressModel(
            name: result[0].name!,
            locality: result[0].locality!,
            countryCode: result[0].isoCountryCode!,
            state: result[0].administrativeArea!,
            street: result[0].street!,
            postalcode: result[0].postalCode!,
            latitude: fetchedData[0].latitude,
            longitude: fetchedData[0].longitude,
            timestamp: fetchedData[0].timestamp,
          );
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    return foundAddress;
  }

  Future changeMapTheme() async {
    _mapController!.setMapStyle('''
                    [
                      {
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#242f3e"
                          }
                        ]
                      },
                      {
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#746855"
                          }
                        ]
                      },
                      {
                        "elementType": "labels.text.stroke",
                        "stylers": [
                          {
                            "color": "#242f3e"
                          }
                        ]
                      },
                      {
                        "featureType": "administrative.locality",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#d59563"
                          }
                        ]
                      },
                      {
                        "featureType": "poi",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#d59563"
                          }
                        ]
                      },
                      {
                        "featureType": "poi.park",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#263c3f"
                          }
                        ]
                      },
                      {
                        "featureType": "poi.park",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#6b9a76"
                          }
                        ]
                      },
                      {
                        "featureType": "road",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#38414e"
                          }
                        ]
                      },
                      {
                        "featureType": "road",
                        "elementType": "geometry.stroke",
                        "stylers": [
                          {
                            "color": "#212a37"
                          }
                        ]
                      },
                      {
                        "featureType": "road",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#9ca5b3"
                          }
                        ]
                      },
                      {
                        "featureType": "road.highway",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#746855"
                          }
                        ]
                      },
                      {
                        "featureType": "road.highway",
                        "elementType": "geometry.stroke",
                        "stylers": [
                          {
                            "color": "#1f2835"
                          }
                        ]
                      },
                      {
                        "featureType": "road.highway",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#f3d19c"
                          }
                        ]
                      },
                      {
                        "featureType": "transit",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#2f3948"
                          }
                        ]
                      },
                      {
                        "featureType": "transit.station",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#d59563"
                          }
                        ]
                      },
                      {
                        "featureType": "water",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#17263c"
                          }
                        ]
                      },
                      {
                        "featureType": "water",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#515c6d"
                          }
                        ]
                      },
                      {
                        "featureType": "water",
                        "elementType": "labels.text.stroke",
                        "stylers": [
                          {
                            "color": "#17263c"
                          }
                        ]
                      }
                    ]
                ''');
  }
}

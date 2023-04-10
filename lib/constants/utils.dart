import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

class Utils {
  static void showToast({
    required BuildContext context,
    required String message,
  }) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      textColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }

  static Future<Position?> getCurrentLocation() async {
    Position? position;
    LocationPermission isPermissionAllowed = await Geolocator.checkPermission();
    if (isPermissionAllowed != LocationPermission.denied) {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } else {
      Geolocator.requestPermission();
      isPermissionAllowed = await Geolocator.checkPermission();
      if (isPermissionAllowed != LocationPermission.denied) {
        position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
      }
    }
    return position;
  }
}

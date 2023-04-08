import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kavish_academy/constants/variables.dart';
import 'package:kavish_academy/models/user_model.dart';

class FirebaseStorageController extends GetxController {
  static FirebaseStorageController instance = Get.find();

  static Future<void> storeUserDataToStorage({
    required String uid,
    required String name,
    required String email,
  }) async {
    try {
      DatabaseReference userRef =
          Variables.firebaseDatabase.ref().child('users');
      UserModel userModel = UserModel(
        name: name,
        email: email,
      );
      await userRef.child(uid).set(userModel.toJson());
    } catch (e) {
      debugPrint(
          'Catch block in FirebaseStorageController.storeUserDataToStorage() ${e.toString()}');
    }
  }
}

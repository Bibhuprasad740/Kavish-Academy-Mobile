import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kavish_academy/constants/variables.dart';
import 'package:kavish_academy/models/user_model.dart';

class FirebaseStorageController extends GetxController {
  static FirebaseStorageController instance = Get.find();

  var firebaseRealTimeUserData = {
    'name': 'Default',
    'email': 'example@gmail.com',
    'uid': 'jvnhgewcjlmglmxesmcvox',
  }.obs;

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
        isPlusMember: false,
      );
      await userRef.child(uid).set(userModel.toJson());
    } catch (e) {
      debugPrint(
          'Catch block in FirebaseStorageController.storeUserDataToStorage() ${e.toString()}');
    }
  }

  static Future getUserData() async {
    try {
      DatabaseReference userRef =
          Variables.firebaseDatabase.ref().child('users');
      DataSnapshot dataSnapshot =
          await userRef.child(Variables.auth.currentUser!.uid).get();
      var firebaseRealTimeUserData = dataSnapshot.value as dynamic;
    } catch (e) {}
  }

  Future<bool> checkPlusMember() async {
    bool isPlusMember = false;
    try {
      DatabaseReference userRef =
          Variables.firebaseDatabase.ref().child('users');
      DataSnapshot dataSnapshot =
          await userRef.child(Variables.auth.currentUser!.uid).get();
      var firebaseRealTimeUserData = dataSnapshot.value as dynamic;
      isPlusMember = firebaseRealTimeUserData['isPlusMember'];
    } catch (e) {
      debugPrint(
          'Catch block in FirebaseStorageController.checkPlusMember(), ${e.toString()}');
    }
    return isPlusMember;
  }
}

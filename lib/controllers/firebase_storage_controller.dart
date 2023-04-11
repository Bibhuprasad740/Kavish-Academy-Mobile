import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kavish_academy/constants/variables.dart';
import 'package:kavish_academy/models/user_model.dart';

class FirebaseStorageController extends GetxController {
  static FirebaseStorageController instance = Get.find();

  Rx<UserModel> firebaseUserData = UserModel(
    name: 'Default',
    email: 'example@gmail.com',
    uid: 'abcdefghijk',
    isPlusMember: false,
  ).obs;

  Rx<bool> isLoading = false.obs;

  UserModel get getUserModel => firebaseUserData.value;

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
        uid: uid,
        isPlusMember: false,
      );
      await userRef.child(uid).set(userModel.toJson());
    } catch (e) {
      debugPrint(
          'Catch block in FirebaseStorageController.storeUserDataToStorage() ${e.toString()}');
    }
  }

  Future<void> setUserData() async {
    isLoading.value = true;
    try {
      DatabaseReference userRef =
          Variables.firebaseDatabase.ref().child('users');
      DataSnapshot dataSnapshot =
          await userRef.child(Variables.auth.currentUser!.uid).get();
      var fetchedUserData = dataSnapshot.value as dynamic;
      UserModel userModel = UserModel.fromMap(fetchedUserData);
      firebaseUserData.value = userModel;
    } catch (e) {
      debugPrint(
        'Catch block in firebaseStorageController.setUserData(), ${e.toString()}',
      );
    }
    isLoading.value = false;
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

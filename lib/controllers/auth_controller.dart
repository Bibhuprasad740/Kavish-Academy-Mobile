// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kavish_academy/constants/utils.dart';
import 'package:kavish_academy/controllers/firebase_storage_controller.dart';
import 'package:kavish_academy/views/screens/bottom_bar_screen.dart';

import '../constants/variables.dart';
import '../views/screens/splash_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  Rx<File?>? pickedImage;
  late Rx<User?> _user;
  Rx<bool> isLoading = false.obs;

  @override
  void onInit() {
    _user = Rx<User?>(Variables.auth.currentUser);
    _user.bindStream(Variables.auth.authStateChanges());
    super.onInit();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  //   _user = Rx<User?>(Variables.auth.currentUser);
  //   _user.bindStream(Variables.auth.authStateChanges());
  //   // ever(_user, _setInitialScreen);
  // }

  // _setInitialScreen(User? user) {
  //   if (user == null) {
  //     Get.offAll(() => const SplashScreen());
  //   } else {
  //     Get.offAll(() => const BottomBarScreen());
  //   }
  // }

  User? get getUser => _user.value;

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    isLoading.value = true;
    try {
      UserCredential userCredential = await Variables.auth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        await FirebaseStorageController.storeUserDataToStorage(
          uid: userCredential.user!.uid,
          name: name,
          email: email,
        ).then((value) {
          _user.value = Variables.auth.currentUser;
        });
        _user.value = Variables.auth.currentUser;
        Utils.showToast(context: context, message: 'Account has been created!');
        Get.offAll(() => const BottomBarScreen());
      } else {
        Utils.showToast(
            context: context, message: 'Account could not be created!');
      }
    } on FirebaseAuthException catch (exception) {
      String result = '';
      debugPrint(
          'AuthController.firebaseAuth exception, code = ${exception.code}');
      if (exception.code == 'email-already-in-use') {
        result = 'You have already registered.';
      } else if (exception.code == 'weak-password') {
        result = 'Password should be at least 6 characters.';
      } else if (exception.code == 'invalid-email') {
        result = 'Please enter a valid email';
      } else if (exception.code == 'network-request-failed') {
        result = 'Connect to internet';
      } else if (exception.code == 'too-many-requests') {
        result = 'Too many requests. Try again later.';
      } else {
        result = exception.code.toString();
      }
      Get.snackbar(result, 'Please try again.');
    } catch (e) {
      Utils.showToast(context: context, message: 'Something went wrong!');
      debugPrint('Catch block in AuthController.signUp() ${e.toString()}');
    }
    isLoading.value = false;
  }

  Future<void> signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    isLoading.value = true;
    try {
      await Variables.auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.offAll(() => const BottomBarScreen());
    } on FirebaseAuthException catch (exception) {
      String result = '';
      if (exception.code == 'user-not-found') {
        result = 'Invalid user. Register first';
      } else if (exception.code == 'network-request-failed') {
        result = 'Connect to internet';
      } else if (exception.code == 'invalid-email') {
        result = 'Please enter valid email';
      } else {
        result = exception.code;
      }
      _user.value = Variables.auth.currentUser;
      Get.snackbar(result, 'Please try again.');
    } catch (e) {
      Utils.showToast(context: context, message: 'Something went wrong!');
      debugPrint('Catch block in AuthController.SignIn() ${e.toString()}');
    }
    isLoading.value = false;
  }

  Future<void> signOut() async {
    try {
      await Variables.auth.signOut();
      Get.offAll(() => const SplashScreen());
      _user.value = null;
    } catch (e) {
      debugPrint('Catch block in AuthController.signOut(), ${e.toString()}');
    }
  }
}

import 'package:get/get.dart';
import 'package:kavish_academy/controllers/firebase_storage_controller.dart';
import 'package:kavish_academy/controllers/theme_controller.dart';

import 'controllers/auth_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(
      () => AuthController(),
      fenix: true,
    );
    Get.lazyPut<ThemeController>(
      () => ThemeController(),
      fenix: true,
    );
    Get.lazyPut<FirebaseStorageController>(
      () => FirebaseStorageController(),
      fenix: true,
    );
  }
}

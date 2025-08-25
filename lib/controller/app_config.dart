import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppConfigContoller extends GetxController {
  var themeMode = ThemeMode.system.obs;

  void changeTheme(ThemeMode mode) {
    themeMode.value = mode;
    Get.changeThemeMode(mode);
  }
}

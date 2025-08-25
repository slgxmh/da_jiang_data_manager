import 'package:da_jiang_data_manager/controller/app_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final AppConfigContoller themeController = Get.find();
    return PopupMenuButton<ThemeMode>(
      icon: const Icon(Icons.brightness_6),
      onSelected: (mode) => themeController.changeTheme(mode),
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: ThemeMode.light,
          child: Text('app_theme_light'.tr),
        ),
        PopupMenuItem(value: ThemeMode.dark, child: Text('app_theme_dark'.tr)),
        PopupMenuItem(
          value: ThemeMode.system,
          child: Text('app_theme_system'.tr),
        ),
      ],
    );
  }
}

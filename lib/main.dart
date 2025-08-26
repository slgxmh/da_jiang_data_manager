import 'package:da_jiang_data_manager/widgets/app_map.dart';
import 'package:da_jiang_data_manager/message.dart';
import 'package:da_jiang_data_manager/controller/app_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/app_bar.dart';
import 'widgets/dataset_viewer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppConfigContoller appController = Get.put(AppConfigContoller());

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        translations: Messages(),
        locale: const Locale('zh', 'CN'),
        fallbackLocale: const Locale('en', 'US'),
        title: 'app_name'.tr,
        theme: ThemeData(
          brightness: Brightness.light,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green,
            brightness: Brightness.light,
          ),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green,
            brightness: Brightness.dark,
          ),
        ),
        themeMode: appController.themeMode.value,
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isDataSetViewerMinimized = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Stack(
        children: [
          /// 背景地图
          const Positioned.fill(child: AppMap()),

          /// 左下角悬浮 DatasetViewer
          Positioned(
            left: 16,
            bottom: 16,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, anim) =>
                  ScaleTransition(scale: anim, child: child),
              child: _isDataSetViewerMinimized
                  ? FloatingActionButton.small(
                      heroTag: "datasetMinimize",
                      onPressed: () {
                        setState(() {
                          _isDataSetViewerMinimized = false;
                        });
                      },
                      child: const Icon(Icons.app_registration),
                    )
                  : Material(
                      elevation: 8,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: 500,
                        height: 400,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            /// 标题栏 + 最小化按钮
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "dataset".tr,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.minimize),
                                  onPressed: () {
                                    setState(() {
                                      _isDataSetViewerMinimized = true;
                                    });
                                  },
                                ),
                              ],
                            ),

                            const Divider(height: 1),

                            /// 内容区域：DatasetViewer
                            Expanded(child: DatasetViewer()),
                          ],
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:da_jiang_data_manager/controller/workspace.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'theme_toggle.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final WorkspaceController workspaceController = Get.put(
    WorkspaceController(),
  );
  final double fontSize = 20;

  MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 240,
      leading: GetBuilder<WorkspaceController>(
        builder: (controller) => Flex(
          direction: Axis.horizontal,
          spacing: 10,
          children: [
            PopupMenuButton<String>(
              onSelected: (value) {
                switch (value) {
                  case 'new':
                    controller.createWorkspace();
                    break;
                  case 'open':
                    controller.openWorkspace();
                    break;
                  case 'save':
                    controller.saveWorkspace();
                    break;
                  case 'save_as':
                    controller.saveAsWorkspace();
                    break;
                  case 'close':
                    controller.closeWorkspace();
                    break;
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    value: 'new',
                    enabled: !controller.isWorkspaceOpen,
                    child: Text('project_new'.tr),
                  ),
                  PopupMenuItem(
                    value: 'open',
                    enabled: !controller.isWorkspaceOpen,
                    child: Text('project_open'.tr),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem(
                    value: 'save',
                    enabled: controller.isWorkspaceOpen,
                    child: Text('project_save'.tr),
                  ),
                  PopupMenuItem(
                    value: 'save_as',
                    enabled: controller.isWorkspaceOpen,
                    child: Text('project_save_as'.tr),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem(
                    value: 'close',
                    enabled: controller.isWorkspaceOpen,
                    child: Text('project_close'.tr),
                  ),
                ];
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('project'.tr, style: TextStyle(fontSize: fontSize)),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'data_add_mrk') {
                  controller.addMrk();
                }
                if (value == 'data_remove_mrk') {
                  controller.removeCurrentMrk();
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    value: 'data_add_mrk',
                    enabled: controller.isWorkspaceOpen,
                    child: Text('data_add_mrk'.tr),
                  ),
                  PopupMenuItem(
                    value: 'data_remove_mrk',
                    enabled: controller.isWorkspaceOpen,
                    child: Text('data_remove_mrk'.tr),
                  ),
                ];
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('data'.tr, style: TextStyle(fontSize: fontSize)),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ],
        ),
      ),
      title: GetBuilder<WorkspaceController>(
        builder: (controller) => Text(
          controller.isWorkspaceOpen
              ? controller.filePath.split("/").last
              : 'app_name'.tr,
        ),
      ),
      actions: [
        const ThemeToggle(),
        PopupMenuButton<Locale>(
          icon: const Icon(Icons.language),
          onSelected: (locale) => Get.updateLocale(locale),
          itemBuilder: (BuildContext context) => const [
            PopupMenuItem(value: Locale('zh', 'CN'), child: Text('中文')),
            PopupMenuItem(value: Locale('en', 'US'), child: Text('English')),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

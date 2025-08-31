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
      leading: Flex(
        direction: Axis.horizontal,
        spacing: 10,
        children: [
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'new':
                  workspaceController.createWorkspace();
                  break;
                case 'open':
                  workspaceController.openWorkspace();
                  break;
                case 'save':
                  workspaceController.saveWorkspace();
                  break;
                case 'save_as':
                  workspaceController.saveAsWorkspace();
                  break;
                case 'close':
                  workspaceController.closeWorkspace();
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'new',
                  enabled: !workspaceController.isWorkspaceOpen,
                  child: Text('project_new'.tr),
                ),
                PopupMenuItem(
                  value: 'open',
                  enabled: !workspaceController.isWorkspaceOpen,
                  child: Text('project_open'.tr),
                ),
                const PopupMenuDivider(),
                PopupMenuItem(
                  value: 'save',
                  enabled: workspaceController.isWorkspaceOpen,
                  child: Text('project_save'.tr),
                ),
                PopupMenuItem(
                  value: 'save_as',
                  enabled: workspaceController.isWorkspaceOpen,
                  child: Text('project_save_as'.tr),
                ),
                const PopupMenuDivider(),
                PopupMenuItem(
                  value: 'close',
                  enabled: workspaceController.isWorkspaceOpen,
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
                workspaceController.addMrk();
              }
              if (value == 'data_remove_mrk') {
                workspaceController.removeCurrentMrk();
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'data_add_mrk',
                  enabled: workspaceController.isWorkspaceOpen,
                  child: Text('data_add_mrk'.tr),
                ),
                PopupMenuItem(
                  value: 'data_remove_mrk',
                  enabled: workspaceController.isWorkspaceOpen,
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
      title: Obx(
        () => Text(
          workspaceController.isWorkspaceOpen
              ? workspaceController.filePath.value.split("/").last
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

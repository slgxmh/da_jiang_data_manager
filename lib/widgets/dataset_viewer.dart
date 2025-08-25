import 'package:da_jiang_data_manager/controller/workspace.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DatasetViewer extends StatelessWidget {
  final WorkspaceController workspaceController = Get.put(
    WorkspaceController(),
  );

  DatasetViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WorkspaceController>(
      builder: (controller) {
        return ListView.builder(
          itemCount: controller.mrkPaths.length,
          itemBuilder: (context, index) {
            return ListTile(title: Text(controller.mrkPaths[index]));
          },
        );
      },
    );
  }
}

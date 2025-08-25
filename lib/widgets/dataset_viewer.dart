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
    return Obx(
      () => ListView.builder(
        itemCount: workspaceController.getMrkPaths().length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(workspaceController.getMrkPaths()[index]),
          );
        },
      ),
    );
  }
}

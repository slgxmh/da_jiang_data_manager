import 'package:da_jiang_data_manager/controller/workspace.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;

class DatasetViewer extends GetView<WorkspaceController> {
  const DatasetViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.mrkDatas.isEmpty) {
        return Center(child: Text("data_viewer_no_data".tr));
      }

      if (!controller.isMrkSelected) {
        return Center(child: Text("data_viewer_no_selected_mrk".tr));
      }

      if (controller.selectedMrkIndex.value >= controller.mrkDatas.length) {
        return const Center(child: CircularProgressIndicator());
      }

      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: DropdownButton<int>(
            value: controller.selectedMrkIndex.value,
            isExpanded: true,
            items: controller.mrkPaths.asMap().entries.map((entry) {
              int index = entry.key;
              String path = entry.value;
              return DropdownMenuItem<int>(
                value: index,
                child: Text(
                  p.basename(path),
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),
            onChanged: (int? newIndex) {
              if (newIndex != null) {
                controller.selectedMrkIndex.value = newIndex;
              }
            },
          ),
        ),
        body: ListView.builder(
          itemCount: controller
              .mrkDatas[controller.selectedMrkIndex.value]
              .items
              .length,
          itemBuilder: (context, index) {
            final item = controller
                .mrkDatas[controller.selectedMrkIndex.value]
                .items[index];
            return Card(
              margin: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              child: ListTile(
                leading: CircleAvatar(child: Text('${item.id}')),
                title: Text('ID: ${item.id}'),
                subtitle: Text('Lat: ${item.lat}, Lon: ${item.lon}'),
              ),
            );
          },
        ),
      );
    });
  }
}

import 'package:da_jiang_data_manager/controller/workspace.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;

class DatasetViewer extends StatefulWidget {
  final WorkspaceController workspaceController = Get.put(
    WorkspaceController(),
  );

  DatasetViewer({super.key});

  @override
  State<DatasetViewer> createState() => _DatasetViewerState();
}

class _DatasetViewerState extends State<DatasetViewer> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WorkspaceController>(
      builder: (controller) {
        if (controller.mrkDatas.isEmpty) {
          return Center(child: Text("data_viewer_no_data".tr));
        }

        // Ensure selectedIndex is valid
        if (_selectedIndex >= controller.mrkDatas.length) {
          _selectedIndex = 0;
        }

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: DropdownButton<int>(
              value: _selectedIndex,
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
                  setState(() {
                    _selectedIndex = newIndex;
                  });
                }
              },
            ),
          ),
          body: ListView.builder(
            itemCount: controller.mrkDatas[_selectedIndex].items.length,
            itemBuilder: (context, index) {
              final item = controller.mrkDatas[_selectedIndex].items[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ListTile(
                  leading: CircleAvatar(child: Text('${item.id}')),
                  title: Text('ID: ${item.id}'),
                  subtitle: Text('Lat: ${item.lat}, Lon: ${item.lon}'),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

import 'package:da_jiang_data_manager/controller/workspace.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;

class DatasetViewer extends StatelessWidget {
  final WorkspaceController workspaceController = Get.put(
    WorkspaceController(),
  );

  DatasetViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WorkspaceController>(
      builder: (controller) {
        if (controller.mrkDatas.isEmpty) {
          return const Center(child: Text("No MRK data loaded."));
        }

        return DefaultTabController(
          length: controller.mrkDatas.length,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: TabBar(
                isScrollable: true,
                tabs: controller.mrkPaths
                    .map((path) => Tab(text: p.basename(path)))
                    .toList(),
              ),
            ),
            body: TabBarView(
              children: controller.mrkDatas.map((mrkData) {
                return ListView.builder(
                  itemCount: mrkData.items.length,
                  itemBuilder: (context, index) {
                    final item = mrkData.items[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: ListTile(
                        leading: CircleAvatar(child: Text('${item.id}')),
                        title: Text('ID: ${item.id}'),
                        subtitle: Text('Lat: ${item.lat}, Lon: ${item.lon}'),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
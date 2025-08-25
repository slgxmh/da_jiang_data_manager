import 'package:da_jiang_data_manager/controller/workspace.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';

class AppMap extends StatefulWidget {
  const AppMap({super.key});

  @override
  State<AppMap> createState() => _AppMapState();
}

class _AppMapState extends State<AppMap> {
  final _mapController = MapController();
  bool _isMapReady = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WorkspaceController>(
      builder: (controller) {
        if (_isMapReady &&
            _mapController.camera.center != controller.centerPoint) {
          _mapController.move(
            controller.centerPoint,
            _mapController.camera.zoom,
          );
        }
        return FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: controller.centerPoint,
            initialZoom: 10,
            onMapReady: () {
              _isMapReady = true;
            },
          ),
          children: [
            TileLayer(
              urlTemplate:
                  'https://wprd0{s}.is.autonavi.com/appmaptile?lang=zh_cn&style=8&x={x}&y={y}&z={z}',
              subdomains: const ['1', '2', '3', '4'],
            ),
          ],
        );
      },
    );
  }
}

import 'package:da_jiang_data_manager/controller/workspace.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class AppMap extends StatefulWidget {
  const AppMap({super.key});

  @override
  State<AppMap> createState() => _AppMapState();
}

class _AppMapState extends State<AppMap> {
  final _mapController = MapController();
  final _controller = Get.find<WorkspaceController>();
  Worker? _centerPointWorker;
  bool _isMapReady = false;

  @override
  void initState() {
    super.initState();
    _centerPointWorker = ever(_controller.centerPoint, (center) {
      if (_isMapReady) {
        _mapController.move(center, _mapController.camera.zoom);
      }
    });
  }

  @override
  void dispose() {
    _centerPointWorker?.dispose();
    _mapController.dispose();
    super.dispose();
  }

  List<Marker> _buildMarkers() {
    final markers = <Marker>[];
    if (_controller.isMrkSelected) {
      for (final item
          in _controller.mrkDatas[_controller.selectedMrkIndex.value].items) {
        markers.add(
          Marker(
            point: LatLng(item.lat, item.lon),
            child: Icon(
              Icons.location_on,
              color: Colors.red,
              key: Key('mrk_item_${item.id}'),
            ),
          ),
        );
      }
    }
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: _controller.centerPoint.value,
        initialZoom: 10,
        onMapReady: () {
          _isMapReady = true;
          if (_mapController.camera.center != _controller.centerPoint.value) {
            _mapController.move(
              _controller.centerPoint.value,
              _mapController.camera.zoom,
            );
          }
        },
      ),
      children: [
        TileLayer(
          urlTemplate:
              'https://wprd0{s}.is.autonavi.com/appmaptile?lang=zh_cn&style=8&x={x}&y={y}&z={z}',
          subdomains: const ['1', '2', '3', '4'],
        ),
        Obx(() => MarkerLayer(markers: _buildMarkers())),
      ],
    );
  }
}

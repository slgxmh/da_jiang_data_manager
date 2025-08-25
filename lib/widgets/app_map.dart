import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class AppMap extends StatelessWidget {
  // 地图中心：北京天安门
  static const LatLng centerPoint = LatLng(39.909187, 116.397451);

  const AppMap({super.key});
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: const MapOptions(initialCenter: centerPoint, initialZoom: 10),
      children: [
        TileLayer(
          urlTemplate:
              'https://wprd0{s}.is.autonavi.com/appmaptile?lang=zh_cn&style=8&x={x}&y={y}&z={z}',
          subdomains: const ['1', '2', '3', '4'],
        ),
      ],
    );
  }
}

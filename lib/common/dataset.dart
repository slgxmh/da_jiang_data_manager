import 'dart:io';

// ------------------ 常量 ------------------
const String imgRGBBandName = "D";
const String imgGBandName = "G";
const String imgNIRBandName = "NIR";
const String imgRBandName = "R";
const String imgREBandName = "RE";

const List<String> imgBandNames = [
  imgRGBBandName,
  imgGBandName,
  imgNIRBandName,
  imgRBandName,
  imgREBandName,
];

final RegExp regFileId = RegExp(r'_\d{1,4}_');
final RegExp regFileType = RegExp(r'_\w+\.');
final RegExp regMrkId = RegExp(r'^\d*');
final RegExp regMrkPos = RegExp(r'\d{2}\.\d{8}');

// ------------------ MRK 数据类 ------------------
/// MRK文件中的一条
class MrkItem {
  final int id;
  final double lat;
  final double lon;

  MrkItem({required this.id, required this.lat, required this.lon});

  Map<String, dynamic> toJson() => {'id': id, 'lat': lat, 'lon': lon};
}

/// 一个MRK文件的数据
class MrkData {
  final String basePath;
  final List<MrkItem> items;

  MrkData({required this.basePath, required this.items});

  factory MrkData.fromMrkFile(String path) {
    final file = File(path);
    if (!file.existsSync()) throw Exception("无法打开文件 $path");
    final basePath = File(path).parent.path;
    final lines = file.readAsLinesSync();

    final items = <MrkItem>[];

    for (var line in lines) {
      final idMatch = regMrkId.firstMatch(line);
      final id = idMatch == null ? 0 : int.parse(idMatch.group(0)!);

      final posMatches = regMrkPos
          .allMatches(line)
          .map((m) => m.group(0)!)
          .toList();
      if (posMatches.length < 2) continue;
      final lat = double.parse(posMatches[0]);
      final lon = double.parse(posMatches[1]);

      items.add(MrkItem(id: id, lat: lat, lon: lon));
    }

    return MrkData(basePath: basePath, items: items);
  }
}

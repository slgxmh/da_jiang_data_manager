import 'dart:convert';
import 'dart:io';

import 'package:da_jiang_data_manager/common/dataset.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

/// 工作空间文件的扩展名
const workspaceExt = "djmw";

/// 工作空间控制器，用于管理工作区的创建、打开、保存等操作
class WorkspaceController extends GetxController {
  /// 当前工作空间文件的路径
  final RxString filePath = ''.obs;

  //  ----- 工作空间中存储的数据 -----
  /// MRK文件路径列表
  final mrkPaths = <String>[];

  /// MRK数据列表，对应MRK数据列表
  final mrkDatas = <MrkData>[];

  // ----- 工作空间用到的数据，无需存储 -----
  /// 工作空间中地图的初始中心点，北京天安门
  LatLng centerPoint = LatLng(39.909187, 116.397451);

  /// 判断当前是否有工作空间处于打开状态
  bool get isWorkspaceOpen => filePath.value.isNotEmpty;

  /// 创建一个新的工作空间
  /// 可以通过[fileName]参数指定默认的文件名
  void createWorkspace({String fileName = 'new_workspace'}) async {
    // 弹出文件保存对话框，让用户选择保存位置和文件名
    String? outputFile = await FilePicker.platform.saveFile(
      dialogTitle: '请选择一个输出文件:',
      fileName: '$fileName.$workspaceExt', // 默认文件名
    );

    // 如果用户选择了文件路径
    if (outputFile != null) {
      filePath.value = outputFile; // 更新文件路径
      _resetWorkspace();
      saveWorkspace(); // 保存新的空工作空间
    }
  }

  /// 打开一个已存在的工作空间
  void openWorkspace() async {
    // 弹出文件选择对话框
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [workspaceExt], // 只允许选择.djmw文件
    );
    if (result == null) return;

    filePath.value = result.files.single.path!; // 更新文件路径
    final file = File(filePath.value);
    final contents = await file.readAsString(); // 读取文件内容
    _fromJson(contents); // 从JSON中恢复数据

    // 加载MRK数据
    for (final path in mrkPaths) {
      mrkDatas.add(MrkData.fromMrkFile(path));
    }
    _computeCenterPoint();

    update();
  }

  /// 保存当前工作空间
  void saveWorkspace() {
    // 确保有工作空间已打开
    if (isWorkspaceOpen) {
      final file = File(filePath.value);
      // 将数据转换为JSON字符串并写入文件
      file.writeAsStringSync(_toJson());
    } else {
      // 如果当前没有打开的工作空间（比如新建的），则调用“另存为”
      saveAsWorkspace();
    }
  }

  /// 将当前工作空间另存为
  void saveAsWorkspace() async {
    // 弹出文件保存对话框
    String? outputFile = await FilePicker.platform.saveFile(
      dialogTitle: '将工作空间另存为...',
      fileName: 'workspace.$workspaceExt',
    );

    // 如果用户选择了路径
    if (outputFile != null) {
      filePath.value = outputFile; // 更新文件路径
      saveWorkspace(); // 保存工作空间
    }
  }

  /// 关闭当前工作空间
  void closeWorkspace() {
    filePath.value = ''; // 清空文件路径
    _resetWorkspace();
    update();
  }

  /// 添加MRK数据
  Future<void> addMrk() async {
    // 弹出文件选择对话框
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [".MRK"], // 只允许选择.MRK文件
    );
    if (result == null) return;

    String path = result.files.single.path!;
    mrkPaths.add(path);
    mrkDatas.add(MrkData.fromMrkFile(path));

    _computeCenterPoint();

    update();
  }

  /// 获取中心点
  void _computeCenterPoint() {
    final points = mrkDatas.map((e) => e.centerPoint).toList();
    final sumLat = points.fold(0.0, (sum, item) => sum + item.latitude);
    final sumLon = points.fold(0.0, (sum, item) => sum + item.longitude);
    var point = LatLng(sumLat / points.length, sumLon / points.length);
    centerPoint = point;
  }

  /// 重置工作空间
  void _resetWorkspace() {
    mrkPaths.clear();
    mrkDatas.clear();
    update();
  }

  String _toJson() {
    return jsonEncode({"mrkPaths": mrkPaths});
  }

  void _fromJson(String json) {
    Map<String, dynamic> data = jsonDecode(json);
    mrkPaths.addAll(List<String>.from(data["mrkPaths"]));
  }
}

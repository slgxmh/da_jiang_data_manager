import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

/// 工作空间文件的扩展名
const workspaceExt = "djmw";

/// 工作空间控制器，用于管理工作区的创建、打开、保存等操作
class WorkspaceController extends GetxController {
  /// 当前工作空间文件的路径，使用.obs使其成为响应式变量
  final RxString filePath = ''.obs;

  /// 工作空间中存储的数据，使用.obs使其成为响应式变量
  final RxList<String> _mrkPaths = <String>[].obs;

  /// 判断当前是否有工作空间处于打开状态
  bool get isWorkspaceOpen => filePath.value.isNotEmpty;

  /// 创建一个新的工作空间
  ///
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
      _mrkPaths.clear();
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

    // 如果用户选择了文件
    if (result != null) {
      filePath.value = result.files.single.path!; // 更新文件路径
      // final file = File(filePath.value);
      // final contents = await file.readAsString(); // 读取文件内容
    }
  }

  /// 保存当前工作空间
  void saveWorkspace() {
    // 确保有工作空间已打开
    // if (isWorkspaceOpen) {
    //   final file = File(filePath.value);
    //   // 将数据转换为JSON字符串并写入文件
    //   file.writeAsStringSync(jsonEncode(_data));
    // } else {
    //   // 如果当前没有打开的工作空间（比如新建的），则调用“另存为”
    //   saveAsWorkspace();
    // }
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
    _mrkPaths.clear(); // 清空数据
  }

  /// 添加MRK数据
  Future<void> addMrk() async {
    // 弹出文件选择对话框
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [".MRK"], // 只允许选择.MRK文件
    );
    if (result != null) {
      String path = result.files.single.path!;
      _mrkPaths.add(path);
    }
  }

  /// 读取MRK文件列表
  List<String> getMrkPaths() {
    return _mrkPaths;
  }
}

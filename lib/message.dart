import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'zh_CN': {
      'app_name': '大酱数据管理器',
      'app_theme': '主题',
      'app_theme_light': '浅色',
      'app_theme_dark': '深色',
      'app_theme_system': '系统',
      'project': '项目',
      'project_open': '打开项目',
      'project_save': '保存项目',
      'project_new': '新建项目',
      'project_save_as': '项目另存为',
      'project_close': '关闭项目',
      'data': '数据',
      'data_add_mrk': '添加MRK',
      'data_remove_mrk': '移除当前MRK',
      'data_viewer_no_data': "请添加MRK数据",
      'data_viewer_no_selected_mrk': "请选择MRK数据",
      'dataset': '数据集',
    },
    'en_US': {
      'app_name': 'DaJiangDataManager',
      'app_theme_light': 'Light',
      'app_theme_dark': 'Dark',
      'app_theme_system': 'System',
      'project': 'Project',
      'project_open': 'Open Project',
      'project_save': 'Save Project',
      'project_new': 'New Project',
      'project_save_as': 'Save Project As',
      'project_close': 'Close Project',
      'data': "Data",
      'data_add_mrk': 'Add MRK',
      'data_remove_mrk': 'Remove Current MRK',
      'data_viewer_no_data': "Please add MRK data",
      'data_viewer_no_selected_mrk': "Please select a MRK",
      'dataset': 'Dataset',
    },
  };
}

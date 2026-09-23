import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileStorageManager {
  static final FileStorageManager _internal = FileStorageManager._();

  FileStorageManager._();

  factory FileStorageManager() {
    return _internal;
  }

  late final Directory _appDocumentsDir;
  late final File _tasksFile;

  Future<void> init() async {
    _appDocumentsDir = await getApplicationDocumentsDirectory();
    _tasksFile = File('${_appDocumentsDir.path}/tasks.json');
  }

  Future<void> saveTasks(List<dynamic> tasks) async {
    final listJson = jsonEncode(tasks);
    await _tasksFile.writeAsString(listJson);
  }

  Future<List<dynamic>> loadTasks() async {
    if (!await _tasksFile.exists()) return [];
    final listJson = await _tasksFile.readAsString();
    return jsonDecode(listJson) as List<dynamic>;
  }

  Future<void> clear() async {
    if (!await _tasksFile.exists()) return;

    await _tasksFile.delete();
  }
}

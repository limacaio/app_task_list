import 'dart:convert';
import 'package:app_task_list/models/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

//shared_preferences para persistencia de poucos dados no dispositivo;
class TaskRepository {
  late SharedPreferences sharedPreferences;

  Future<List<Task>> getTaskList() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString = sharedPreferences.getString('task_list') ?? '[]';
    //decodificando o json
    final List jsonDecoded = json.decode(jsonString) as List;
    return jsonDecoded.map((e) => Task.fromJson(e)).toList();
  }

  void saveTaskList(List<Task> tasks) {
    String jsonString = json.encode(tasks);
    //salvnado o arquivo json no dispositivo
    sharedPreferences.setString('task_list', jsonString);
  }
}

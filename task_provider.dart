import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  TaskProvider() {
    loadTasks();
  }

  void addTask(String title) {
    _tasks.add(Task(title: title));
    saveTasks();
    notifyListeners();
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
    saveTasks();
    notifyListeners();
  }

  void toggleTask(int index) {
    _tasks[index].isCompleted = !_tasks[index].isCompleted;
    saveTasks();
    notifyListeners();
  }

  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();

    List<String> taskList =
        _tasks.map((task) => jsonEncode(task.toJson())).toList();

    await prefs.setStringList('tasks', taskList);
  }

  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();

    List<String>? taskList = prefs.getStringList('tasks');

    if (taskList != null) {
      _tasks = taskList
          .map((task) => Task.fromJson(jsonDecode(task)))
          .toList();

      notifyListeners();
    }
  }
}

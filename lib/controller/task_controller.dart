import 'package:flutter/material.dart';
import 'package:task_manager/model/task.dart';
import 'package:task_manager/view/task_list_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TaskController extends StatefulWidget {
  @override
  _TaskControllerState createState() => _TaskControllerState();
}

class _TaskControllerState extends State<TaskController> {
  late List<Task> _tasks = []; // Initialize _tasks as an empty list

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _markTaskIncomplete(Task task) {
    setState(() {
      task.isCompleted = false;
    });
    _saveTasks();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Task marked as incomplete'),
      ),
    );
  }

  void _loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? tasksJson = prefs.getStringList('tasks');
    if (tasksJson != null) {
      setState(() {
        _tasks = tasksJson.map((taskJson) => Task.fromJson(json.decode(taskJson))).toList();
      });
    }
  }

  void _saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasksJson = _tasks.map((task) => json.encode(task.toJson())).toList();
    prefs.setStringList('tasks', tasksJson);
  }

  void _addTask(Task task) {
    setState(() {
      _tasks.insert(_tasks.length - 1, task); // Inserts the task before the last one (the "Add Task" button)
      _saveTasks();
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
      _saveTasks();
    });
  }

  void _toggleTaskCompleted(int index) {
    setState(() {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
      _saveTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return TaskListScreen(
      tasks: _tasks,
      markTaskIncomplete: _markTaskIncomplete,
      addTask: _addTask,
      deleteTask: _deleteTask,
      toggleTaskCompleted: _toggleTaskCompleted,
    );
  }
}

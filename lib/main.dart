import 'package:flutter/material.dart';
import 'package:task_manager/controller/task_controller.dart';

void main() {
  runApp(TaskTrackerApp());
}

class TaskTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskController(),
      debugShowCheckedModeBanner: false,
    );
  }
}

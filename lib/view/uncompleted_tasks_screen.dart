import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/model/task.dart';

import 'edit_task_screen.dart';

class UncompletedTasksScreen extends StatefulWidget {
  final List<Task> tasks;

  UncompletedTasksScreen({required this.tasks});

  @override
  _UncompletedTasksScreenState createState() => _UncompletedTasksScreenState();
}

class _UncompletedTasksScreenState extends State<UncompletedTasksScreen> {
  @override
  Widget build(BuildContext context) {
    final uncompletedTasks = widget.tasks.where((task) => !task.isCompleted).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Uncompleted Tasks',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 30,
              color: Colors.red
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: uncompletedTasks.length,
            itemBuilder: (context, index) {
              final task = uncompletedTasks[index];
              return Card(
                elevation: 2,
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                child: ListTile(
                  title: Text(
                    task.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(task.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: false,
                        onChanged: (newValue) {
                          _markTaskCompleted(context, task);
                        },
                        activeColor: Colors.blue,
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _editTask(context, task);
                        },
                        color: Colors.blueGrey,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _editTask(BuildContext context, Task task) async {
    final editedTask = await Navigator.push<Task?>(
      context,
      MaterialPageRoute(builder: (context) => EditTaskScreen(task: task)),
    );
    if (editedTask != null) {
      setState(() {
        // replace the edited task with the original task
        widget.tasks[widget.tasks.indexWhere((element) => element == task)] = editedTask;
      });
    }
  }

  void _markTaskCompleted(BuildContext context, Task task) {
    setState(() {
      task.isCompleted = true;
    });
    _saveTasks();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Task marked as completed'),
    ));
  }

  void _saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasksJson = widget.tasks.map((task) => json.encode(task.toJson())).toList();
    prefs.setStringList('tasks', tasksJson);
  }
}

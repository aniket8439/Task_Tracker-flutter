import 'package:flutter/material.dart';
import 'package:task_manager/model/task.dart';
import 'package:task_manager/view/add_task_screen.dart';
import 'package:task_manager/view/completed_task_screen.dart';
import 'package:task_manager/view/uncompleted_tasks_screen.dart';

class TaskListScreen extends StatefulWidget {
  final List<Task> tasks;
  final Function(Task) markTaskIncomplete;
  final Function(Task) addTask;
  final Function(int) deleteTask;
  final Function(int) toggleTaskCompleted;

  TaskListScreen({
    required this.tasks,
    required this.markTaskIncomplete,
    required this.addTask,
    required this.deleteTask,
    required this.toggleTaskCompleted,
  });

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Task Tracker',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: _getBody(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.6),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.pending),
            label: 'Uncompleted Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: 'Completed Tasks',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Task? newTask = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          );
          if (newTask != null) {
            widget.addTask(newTask);
          }
        },
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _getBody(int index) {
    switch (index) {
      case 1:
        return CompletedTasksScreen(
          tasks: widget.tasks,
          deleteTask: widget.deleteTask,
          markTaskIncomplete: widget.markTaskIncomplete,
        );
      case 0:
        return UncompletedTasksScreen(tasks: widget.tasks);
      default:
        return Container();
    }
  }
}

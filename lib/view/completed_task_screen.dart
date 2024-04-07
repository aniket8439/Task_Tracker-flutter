import 'package:flutter/material.dart';
import 'package:task_manager/model/task.dart';

class CompletedTasksScreen extends StatelessWidget {
  final List<Task> tasks;
  final Function(int) deleteTask;
  final Function(Task) markTaskIncomplete;

  CompletedTasksScreen({
    required this.tasks,
    required this.deleteTask,
    required this.markTaskIncomplete,
  });

  @override
  Widget build(BuildContext context) {
    final completedTasks = tasks.where((task) => task.isCompleted).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Completed Tasks',style: TextStyle(color: Colors.green,fontWeight: FontWeight.w900,fontSize: 30),),
      ),
      body: completedTasks.isEmpty
          ? Center(
        child: Text(
          'No completed tasks yet.',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      )
          : ListView.builder(
        itemCount: completedTasks.length,
        itemBuilder: (context, index) {
          final task = completedTasks[index];
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
                    value: task.isCompleted,
                    onChanged: (value) {
                      markTaskIncomplete(task);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // here, we need to get the index of the completed task from the original tasks list
                      final originalIndex = tasks.indexOf(task);
                      // then we delete it from the original tasks list
                      deleteTask(originalIndex);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

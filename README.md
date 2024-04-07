# task_manager

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.


Setting Up the Project:
1. Clone the project repository from GitHub:
   git clone https://github.com/your-username/task_manager.git
   
2. Navigate to the project directory:
   cd task_manager
3. Install dependencies:
   flutter pub get
4. Run the project on your preferred device:
   flutter run

   
Project Structure:
The project structure is organized as follows:

  lib/: Contains the Dart files for the Flutter project.
  model/: Contains the Dart files defining the data model.
  view/: Contains the Dart files for different screens and views.
  controller/: Contains the Dart files managing the business logic of the application.
  pubspec.yaml: Defines the project dependencies and metadata.
  
How to Use:

Task Manager App:
The Task Manager app allows users to track their tasks, mark them as completed, edit existing tasks, and add new tasks.

Adding a Task:

Click on the floating action button (+) on the Task List screen to add a new task.
Enter the title and description of the task and click on "Add Task" to save it.

Editing a Task:

Click on the "Edit" icon next to a task on the Uncompleted Tasks screen to edit the task details.
Modify the title and description as needed and click on "Save" to update the task.

Marking a Task as Completed:

On the Uncompleted Tasks screen, click on the checkbox next to a task to mark it as completed.
The task will be moved to the Completed Tasks screen.

Deleting a Task:

On the Completed Tasks screen, click on the "Delete" icon next to a task to delete it.
The task will be permanently removed from the list.

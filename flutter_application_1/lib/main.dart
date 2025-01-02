import 'package:flutter/material.dart';

enum Priority { high, medium, low }

class Task {
  String title;
  Priority priority;

  Task({required this.title, required this.priority});
}

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoHomePage(),
    );
  }
}

class TodoHomePage extends StatefulWidget {
  @override
  _TodoHomePageState createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final List<Task> _tasks = [];
  final TextEditingController _taskController = TextEditingController();
  Priority _selectedPriority = Priority.low;

  void _addTask() {
    if (_taskController.text.isNotEmpty) {
      setState(() {
        _tasks.add(Task(
          title: _taskController.text,
          priority: _selectedPriority,
        ));
        _taskController.clear();
        _selectedPriority = Priority.low;
      });
    }
  }

  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo App'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(
                      labelText: 'Task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                DropdownButton<Priority>(
                  value: _selectedPriority,
                  items: [
                    DropdownMenuItem(
                      child: Text('High'),
                      value: Priority.high,
                    ),
                    DropdownMenuItem(
                      child: Text('Medium'),
                      value: Priority.medium,
                    ),
                    DropdownMenuItem(
                      child: Text('Low'),
                      value: Priority.low,
                    ),
                  ],
                  onChanged: (Priority? value) {
                    setState(() {
                      _selectedPriority = value!;
                    });
                  },
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addTask,
                  child: Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return Card(
                  child: ListTile(
                    title: Text(task.title),
                    subtitle: Text(task.priority.toString().split('.').last),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeTask(index),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

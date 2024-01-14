import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: TodoScreen(),
    );
  }
}

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<TodoItem> todos = [];
  TextEditingController todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do App'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: todoController,
                    decoration: InputDecoration(
                      hintText: 'Enter a task',
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    addTodo();
                  },
                  child: Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(todos[index].task),
                  leading: Checkbox(
                    value: todos[index].isCompleted,
                    onChanged: (bool? value) {
                      toggleTodo(index);
                    },
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      removeTodo(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void addTodo() {
    setState(() {
      String newTodo = todoController.text.trim();
      if (newTodo.isNotEmpty) {
        todos.add(TodoItem(task: newTodo, isCompleted: false));
        todoController.clear();
      }
    });
  }

  void removeTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  void toggleTodo(int index) {
    setState(() {
      todos[index].isCompleted = !todos[index].isCompleted;
    });
  }
}

class TodoItem {
  String task;
  bool isCompleted;

  TodoItem({required this.task, required this.isCompleted});
}

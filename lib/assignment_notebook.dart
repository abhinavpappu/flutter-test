import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssignmentNotebook extends StatefulWidget {
  @override
  AssignmentNotebookState createState() => AssignmentNotebookState();
}

class AssignmentNotebookState extends State<AssignmentNotebook> {
  final _tasks = <String>[];
  var _currentlyEditing = -1;
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      final storedTasks = prefs.getStringList('tasks') ?? <String>[];
      _tasks.addAll(storedTasks);
    });
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assignment Notebook'),
      ),
      body: _createTaskList(),
    );
  }

  Widget _createTaskList() {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();

        final index = i ~/ 2; // integer divide (5 / 2 === 2)

        if (index == _currentlyEditing) {
          return TextField(
            autofocus: true,
            controller: TextEditingController(text: _tasks[index]),
            onSubmitted: (value) {
              setState(() {
                _tasks[index] = value;
                _currentlyEditing = -1;
                save();
              });
            },
          );
        }

        if (index < _tasks.length) {
          return ListTile(
            title: Text(
              _tasks[index],
              style: _biggerFont
            ),
            onTap: () {
              setState(() {
                _currentlyEditing = index;
              });
            },
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  _tasks.removeAt(index);
                  save();
                });
              },
            ),
          );
        }

        else if (index ==_tasks.length) {
          return TextField(
            onSubmitted: (value) {
              setState(() {
                _tasks.add(value);
                save();
              });
            },
          );
        }

        return null;
      },
    );
  }

  save() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setStringList('tasks', _tasks);
  }
}
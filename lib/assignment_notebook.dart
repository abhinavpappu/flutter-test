import 'package:flutter/material.dart';

class AssignmentNotebook extends StatefulWidget {
  @override
  AssignmentNotebookState createState() => AssignmentNotebookState();
}

class AssignmentNotebookState extends State<AssignmentNotebook> {
  final _tasks = <String>[];
  final currentlyEditing = -1;
  final _biggerFont = const TextStyle(fontSize: 18.0);

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

        if (index == currentlyEditing) {
          return TextField(
            onSubmitted: (value) {
              setState(() {
                _tasks[index] = value;
                currentlyEditing = -1;
              });
            },
          )
        }

        if (index < _tasks.length) {
          return ListTile(
            title: Text(
              _tasks[index],
              style: _biggerFont
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  _tasks.removeAt(index);
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
              });
            },
          );
        }

        return null;
      },
    );
  }
}
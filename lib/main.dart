import 'package:flutter/material.dart';
import 'random_words_list.dart';
import 'assignment_notebook.dart';
import 'calculator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Welcome to Flutter',
      theme: ThemeData(
        primaryColor: Colors.white
      ),
      // home: RandomWords(),
      // home: AssignmentNotebook(),
      home: Calculator(),
    );
  }
}
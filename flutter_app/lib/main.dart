import 'package:flutter/material.dart';
import 'package:flutter_app/screens/student.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Info',
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        accentColor: Colors.redAccent,
      ),
      home: Student(),
    );
  }
}

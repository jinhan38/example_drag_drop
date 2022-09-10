import 'package:example_drag_drop/dropAreaPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File Drag and Drop',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DropAreaPage(),
    );
  }
}

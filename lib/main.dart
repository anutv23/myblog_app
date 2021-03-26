import 'package:flutter/material.dart';
import 'package:myblog_app/views/Dashboard.dart';
import 'package:myblog_app/views/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: Dashboard(),
    );
  }
}

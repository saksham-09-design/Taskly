import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskly/pages/home_page.dart';

void main() async {
  await Hive.initFlutter("hive_Pages");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

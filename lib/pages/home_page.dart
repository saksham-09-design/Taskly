import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  State<StatefulWidget> createState() {
    return _HomePageClass();
  }
}

class _HomePageClass extends State<HomePage> {
  _HomePageClass();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 138, 36, 255),
        title: const Text(
          "TASKLY!",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

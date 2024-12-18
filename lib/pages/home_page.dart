import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  HomePage();

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
        backgroundColor: Colors.blue,
        title: const Text(
          "TASKLY!",
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: _taskList(),
    );
  }

  Widget _taskList() {
    return ListView(
      children: const [
        ListTile(
          title: Text(
            "Do Code!",
            style: TextStyle(
              decoration: TextDecoration.lineThrough,
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

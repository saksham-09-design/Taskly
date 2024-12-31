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
      floatingActionButton: _floatingButton(context),
    );
  }

  Widget _taskList() {
    return ListView(
      children: [
        ListTile(
          title: const Text(
            "Do Code!",
            style: TextStyle(
              decoration: TextDecoration.lineThrough,
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.w400,
            ),
          ),
          subtitle: Text(
            DateTime.now().toString(),
          ),
          trailing: const Icon(
            Icons.check_box_outlined,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }

  Widget _floatingButton(context) {
    final scaffold = ScaffoldMessenger.of(context);
    return (FloatingActionButton(
      backgroundColor: Colors.blue,
      shape: const CircleBorder(),
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
      onPressed: () {
        scaffold.showSnackBar(
          SnackBar(
            backgroundColor: Colors.blue,
            content: const Text(
              "Task Added!",
            ),
            action: SnackBarAction(
              label: "OK",
              textColor: Colors.white,
              backgroundColor: Colors.blue,
              onPressed: () => scaffold.hideCurrentSnackBar,
            ),
          ),
        );
      },
    ));
  }
}

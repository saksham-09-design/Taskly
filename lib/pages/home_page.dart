import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskly/modals/task.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  State<StatefulWidget> createState() {
    return _HomePageClass();
  }
}

class _HomePageClass extends State<HomePage> {
  _HomePageClass();

  String? _newTask;
  Box? _box;

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
      body: _taskView(),
      floatingActionButton: _floatingButton(),
    );
  }

  Widget _taskList() {
    List taskItems = _box!.values.toList();
    return ListView.builder(
        itemCount: taskItems.length,
        itemBuilder: (BuildContext context, int index) {
          return {
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
          );
          }
        };
  );
  }

  Widget _taskView() {
    return FutureBuilder(
        future: Hive.openBox('task'),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            _box = snapshot.data;
            return _taskList();
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _floatingButton() {
    return (FloatingActionButton(
      backgroundColor: Colors.blue,
      shape: const CircleBorder(),
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
      onPressed: () {
        displayDialog();
      },
    ));
  }

  void displayDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add New Task:"),
            content: TextField(
              onSubmitted: (value) {},
              onChanged: (value) {
                setState(() {
                  _newTask = value;
                });
              },
            ),
            actions: [
              MaterialButton(
                  onPressed: () {
                    showToast(content: "Task Created");
                  },
                  padding: const EdgeInsets.all(2),
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ))
            ],
          );
        });
  }

  void showToast({required String content}) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.blue,
        content: Text(
          content,
        ),
        action: SnackBarAction(
          label: "OK",
          textColor: Colors.white,
          backgroundColor: Colors.blue,
          onPressed: () => scaffold.hideCurrentSnackBar,
        ),
      ),
    );
  }
}

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
          var task = Task.fromMap(taskItems[index]);
          return ListTile(
            title: Text(
              task.content,
              style: TextStyle(
                decoration: task.isDone ? TextDecoration.lineThrough : null,
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w400,
              ),
            ),
            subtitle: Text(
              task.timestamp.toString(),
            ),
            trailing: Icon(
              task.isDone
                  ? Icons.check_box_outlined
                  : Icons.check_box_outline_blank,
              color: Colors.blue,
            ),
          );
        });
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
              onSubmitted: (_) {
                if (_newTask != null || _newTask != "") {
                  Task task = Task(
                      content: _newTask!,
                      timestamp: DateTime.now(),
                      isDone: false);
                  _box?.add(task.toMap());
                  showToast(content: "Task Added!");
                  setState(() {
                    _newTask = null;
                    Navigator.pop(context);
                  });
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Task Cant Be Empty!"),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text(
                                  "OK",
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                )),
                          ],
                        );
                      });
                }
              },
              onChanged: (value) {
                setState(() {
                  _newTask = value;
                });
              },
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (_newTask != null && _newTask != "") {
                    Task task = Task(
                        content: _newTask!,
                        timestamp: DateTime.now(),
                        isDone: false);
                    _box?.add(task.toMap());
                    showToast(content: "Task Added!");
                    setState(() {
                      _newTask = null;
                      Navigator.pop(context);
                    });
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Task Cant Be Empty!"),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text(
                                    "OK",
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                  )),
                            ],
                          );
                        });
                  }
                },
                autofocus: true,
                child: const Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
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

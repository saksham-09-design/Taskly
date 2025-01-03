import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskly/modals/task.dart';
import 'package:taskly/app_Color/Pcolor.dart';

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
  double? _deviceHeight;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: _deviceHeight! * 0.25,
        backgroundColor: pColor,
        title: Row(
          children: [
            const Text(
              "Welcome to\nTaskly!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 40),
              height: _deviceHeight! * .18,
              width: _deviceHeight! * .16,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage("assets/images/Panda.png"))),
            )
          ],
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
              color: pColor,
            ),
            onTap: () {
              task.isDone = !task.isDone;
              _box!.putAt(index, task.toMap());
              setState(() {});
            },
            onLongPress: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Delete This Task?"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              _box!.deleteAt(index);
                              setState(() {});
                              Navigator.pop(context);
                            },
                            child: Text(
                              "YES",
                              style: TextStyle(
                                color: pColor,
                              ),
                            )),
                      ],
                    );
                  });
            },
          );
        });
  }

  Widget _taskView() {
    return FutureBuilder(
        future: Hive.openBox('task'),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
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
      backgroundColor: pColor,
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
                                child: Text(
                                  "OK",
                                  style: TextStyle(
                                    color: pColor,
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
                                  child: Text(
                                    "OK",
                                    style: TextStyle(
                                      color: pColor,
                                    ),
                                  )),
                            ],
                          );
                        });
                  }
                },
                autofocus: true,
                child: Text(
                  "Save",
                  style: TextStyle(
                    color: pColor,
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
        backgroundColor: pColor,
        content: Text(
          content,
        ),
        action: SnackBarAction(
          label: "OK",
          textColor: Colors.white,
          backgroundColor: pColor,
          onPressed: () => scaffold.hideCurrentSnackBar,
        ),
      ),
    );
  }
}

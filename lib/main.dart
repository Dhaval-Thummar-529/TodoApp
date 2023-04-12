import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Details Application",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyTodoApp(),
    );
  }
}

class MyTodoApp extends StatefulWidget {
  const MyTodoApp({super.key});

  @override
  _MyTodoApp createState() => _MyTodoApp();
}

class _MyTodoApp extends State<MyTodoApp> {
  final List<String> _todoList = <String>[];
  final TextEditingController _textEditingController = TextEditingController();

  Widget getBody() {
    if (_todoList.isEmpty) {
      return const Center(child: Text("All tasks are finished!"));
    } else {
      return ListView(
        children: _getItems(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: new Drawer(),
      appBar: AppBar(
        title: const Text("To-do List"),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: SafeArea(child: getBody()),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayDialog(context),
        tooltip: "Add Task",
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void addTodoItem(String title) async {
    setState(() {
      _todoList.add(title);
    });
    _textEditingController.clear();
  }

  Future<Future> _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add a task to your list"),
            content: TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(hintText: "Enter task here"),
              autofocus: true,
            ),
            actions: <Widget>[
              MaterialButton(
                onPressed: () {
                  FocusManager.instance.primaryFocus!.unfocus();
                  if (_textEditingController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please Enter task to add"),
                      duration: Duration(seconds: 5),
                    ));
                  } else {
                    Navigator.of(context).pop();
                    addTodoItem(_textEditingController.text);
                  }
                },
                child: const Text("ADD"),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("CANCEL"),
              )
            ],
          );
        });
  }

  List<Widget> _getItems() {
    final List<Widget> _todoWidget = <Widget>[];
    for (String title in _todoList) {
      _todoWidget.add(_buildTodoItem(title));
    }
    return _todoWidget;
  }

  Widget _buildTodoItem(String title) {
    return ListTile(
      title: Text(title),
    );
  }
}

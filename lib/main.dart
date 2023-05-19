import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:todo_app/Model/TodoModel.dart';
import 'package:todo_app/Service/DatabaseHandler.dart';
import 'package:todo_app/constants/getPages.dart';
import 'package:todo_app/screens/splashScreen.dart';

import 'screens/ToDo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return GetMaterialApp(
      title: "Todo App",
      debugShowCheckedModeBanner: false,
      getPages: getPages,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CSplashScreen(),
    );
  }
}

class MyTodoApp extends StatefulWidget {
  const MyTodoApp({super.key});

  @override
  _MyTodoApp createState() => _MyTodoApp();
}

class _MyTodoApp extends State<MyTodoApp> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();

  //To-do list from database
  late Future<List<TodoModel>> todoList;

  //Active list from database
  late Future<List<TodoModel>> activeList;

  //Finished list from database
  late Future<List<TodoModel>> finishedList;

  late DatabaseHandler handler;

  @override
  void initState() {
    super.initState();
    //To-do list from database
    handler = DatabaseHandler();
    todoList = handler.retrieveTodo("Todo");
    activeList = handler.retrieveTodo("Active");
    finishedList = handler.retrieveTodo("Finished");
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: new Drawer(),
        appBar: AppBar(
          title: const Text("To-do List"),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: "To-Do",
              ),
              Tab(
                text: "Active",
              ),
              Tab(
                text: "Finished",
              ),
            ],
          ),
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
        body: TabBarView(
          children: [
            ToDo(
              todoList: todoList,
            ),
            ToDo(
              todoList: activeList,
            ),
            ToDo(
              todoList: finishedList,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _displayDialog(context),
          tooltip: "Add Task",
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Future<Future> _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add a task to your list"),
            content: Wrap(
              children: [
                Column(
                  children: [
                    TextField(
                      controller: _title,
                      textInputAction: TextInputAction.next,
                      decoration:
                          const InputDecoration(hintText: "Enter task here"),
                      autofocus: true,
                    ),
                    TextField(
                      controller: _description,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                          hintText: "Enter description here"),
                      autofocus: true,
                    ),
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              MaterialButton(
                onPressed: () {
                  FocusManager.instance.primaryFocus!.unfocus();
                  if (_title.text.isEmpty || _description.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please fill all fields to add task!"),
                      duration: Duration(seconds: 5),
                    ));
                  } else {
                    TodoModel todo = TodoModel(
                        title: _title.value.text,
                        description: _description.value.text,
                        status: "Todo");
                    DatabaseHandler().insertTodo(todo);
                    setState(() {
                      todoList = handler.retrieveTodo("Todo");
                    });
                    Navigator.of(context).pop();
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
}

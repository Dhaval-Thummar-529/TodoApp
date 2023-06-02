import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/MyTodoAppController.dart';

class MyTodoApp extends StatelessWidget {

  final MyTodoAppController controller = Get.put(MyTodoAppController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: const Drawer(),
        appBar: AppBar(
          title: const Text("To-do App"),
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
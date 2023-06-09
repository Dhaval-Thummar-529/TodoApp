import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/MyTodoAppController.dart';
import '../Model/TodoModel.dart';
import '../Service/DatabaseHandler.dart';
import 'Active.dart';
import 'Finished.dart';
import 'ToDo.dart';

class MyTodoApp extends StatelessWidget {
  //MyTodo
  final MyTodoAppController controller = Get.put(MyTodoAppController());

  //Widget Tree
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
            //Tab for TodoList
            ToDo(),
            //Tab for ActiveList
            Active(
              activeList: controller.activeList,
            ),
            //Tab for FinishedList
            Finished(
              finishedList: controller.finishedList,
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
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add a task to your list"),
            content: Obx(
              () => controller.isGettingUpdated.value
                  ? const CircularProgressIndicator()
                  : Wrap(
                      children: [
                        Column(
                          children: [
                            TextField(
                              controller: controller.title,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                  hintText: "Enter task here"),
                              autofocus: true,
                            ),
                            TextField(
                              controller: controller.description,
                              textInputAction: TextInputAction.done,
                              decoration: const InputDecoration(
                                  hintText: "Enter description here"),
                              autofocus: true,
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
            actions: <Widget>[
              MaterialButton(
                onPressed: () {
                  controller.addTodoList(context);
                },
                child: const Text("ADD"),
              ),
              MaterialButton(
                onPressed: () {
                  controller.emptyFields();
                  Get.back();
                },
                child: const Text("CANCEL"),
              )
            ],
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/constants/RouteConstants.dart';
import 'package:todo_app/controllers/MyTodoAppController.dart';
import '../Model/TodoModel.dart';
import '../Service/DatabaseHandler.dart';
import 'Active.dart';
import 'Finished.dart';
import 'ToDo.dart';

class MyTodoApp extends StatelessWidget {
  //Widget Tree
  @override
  Widget build(BuildContext context) {
    final MyTodoAppController controller = Get.put(MyTodoAppController());
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
            Obx(() => ToDo(todoList: controller.todoList.value)),
            //Tab for ActiveList
            Obx(() => ToDo(todoList: controller.todoList.value)),
            //Tab for FinishedList
            Obx(() => ToDo(todoList: controller.todoList.value)),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.toNamed(RouteConstants.addTodo),
          tooltip: "Add Task",
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

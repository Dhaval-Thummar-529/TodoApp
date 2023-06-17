import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/MyTodoAppController.dart';
import 'package:todo_app/controllers/TodoController.dart';

import '../Model/TodoModel.dart';
import '../Service/DatabaseHandler.dart';

class ToDo extends StatelessWidget {
  final List<TodoModel> todoList;

  ToDo({super.key, required this.todoList});

  //final TodoController controller = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: todoList.isNotEmpty
              ? ListView.builder(
                  itemCount: todoList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(8),
                        title: Text(todoList[index].title),
                        subtitle: Text(todoList[index].description),
                      ),
                    );
                  })
              : const Center(
                  child: Text(
                    "No task to do!",
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ),
        ),
      ),
    );
  }
}

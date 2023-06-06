import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/TodoController.dart';

import '../Model/TodoModel.dart';
import '../Service/DatabaseHandler.dart';

class ToDo extends StatelessWidget {
  final String todoType;
  ToDo({super.key, required this.todoType});

  final TodoController controller = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: controller.cList.isNotEmpty
              ? ListView.builder(
                  itemCount: controller.cList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(8),
                        title: Text(controller.cList[index].title),
                        subtitle: Text(controller.cList[index].description),
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

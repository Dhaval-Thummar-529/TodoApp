import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/TodoController.dart';

import '../customWidgets/customCheckBox.dart';

class ToDo extends StatelessWidget {
  ToDo({super.key});

  final TodoController controller = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
          child: Center(
            child: Obx(
              () => controller.isLoading.value
                  ? const CircularProgressIndicator(
                      color: Colors.blue,
                    )
                  : controller.todoList.isNotEmpty
                      ? ListView.builder(
                          itemCount: controller.todoList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return TodoListTile(index: index);
                          })
                      : const Center(
                          child: Text(
                            "No task to do!",
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                        ),
            ),
          ),
        ),
      ),
    );
  }
}

class TodoListTile extends StatelessWidget {
  final int index;
  var controller = Get.find<TodoController>();

  TodoListTile({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      //color: Colors.green.withOpacity(0.8),   ////////pending due to color logic
        elevation: 10,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    controller.todoList[index].title,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    controller.todoList[index].description,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        "Start Date : ${controller.todoList[index].startDate}",
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "End Date   : ${controller.todoList[index].startDate}",
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  CustomCheckBox(onChange: (val) {
                    if (val!) {
                      print(val);
                    } else {
                      print(val);
                    }
                  })
                ],
              ),
            ],
          ),
        ));
  }
}

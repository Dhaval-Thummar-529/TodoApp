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
        color: controller.getDateDifference(controller.todoList[index].startDate!, controller.todoList[index].endDate!)+1 <= 1 ? Colors.red.withOpacity(0.8) : controller.getDateDifference(controller.todoList[index].startDate!, controller.todoList[index].endDate!)+1 <= 2 ? Colors.orangeAccent.withOpacity(0.8) : Colors.green.withOpacity(0.8),
        elevation: 10,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 150,
                    child: Text(
                      controller.todoList[index].title,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: Text(
                      controller.todoList[index].description,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
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
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "End Date   : ${controller.todoList[index].endDate}",
                        style: const TextStyle(
                          color: Colors.white,
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

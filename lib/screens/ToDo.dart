import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/TodoController.dart';

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
                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: ListTile(
                                title: Text(controller.todoList[index].title),
                                subtitle: Text(
                                    controller.todoList[index].description),
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
        ),
      ),
    );
  }
}

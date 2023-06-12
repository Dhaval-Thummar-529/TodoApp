import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/AddTodoController.dart';
import 'package:todo_app/customWidgets/customFiled.dart';

class AddTodo extends StatelessWidget {
  AddTodo({super.key});

  final AddTodoController controller = Get.put(AddTodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Todo"),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(28.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomImputField(
              controller: controller.title,
              hintText: "Enter task here",
              label: "Enter Task",
              textInputAction: TextInputAction.next,
              maxLines: 1,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomImputField(
              controller: controller.description,
              hintText: "Enter description here",
              label: "Enter Description",
              textInputAction: TextInputAction.done,
              maxLines: 6,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.date_range,
                        color: Colors.blue,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      TextButton(
                        onPressed: () async {
                          controller.isStart(true);
                          await controller.openDateTimePicker(context);
                        },
                        child: const Text(
                          "Start Date",
                          style: TextStyle(color: Colors.blue, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  child: SizedBox(
                    width: 20,
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.date_range,
                        color: Colors.blue,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      TextButton(
                        onPressed: () {
                          controller.isEnd(true);
                          controller.openDateTimePicker(context);
                        },
                        child: const Text(
                          "End Date",
                          style: TextStyle(color: Colors.blue, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      controller.startDate as String,
                      style: const TextStyle(color: Colors.blue, fontSize: 20),
                    ),
                  ),
                ),
                const Expanded(
                  child: SizedBox(
                    width: 20,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      controller.endDate as String,
                      style: const TextStyle(color: Colors.blue, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/ActiveController.dart';
import 'package:todo_app/controllers/TodoController.dart';

import '../customWidgets/customCheckBox.dart';

class Active extends StatelessWidget {
  Active({super.key});

  final ActiveController controller = Get.put(ActiveController());

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
                  : controller.active.isNotEmpty
                      ? ListView.builder(
                          itemCount: controller.active.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ActiveListTile(index: index);
                          })
                      : const Center(
                          child: Text(
                            "No Active Task!",
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

class ActiveListTile extends StatelessWidget {
  final int index;
  var controller = Get.find<ActiveController>();

  ActiveListTile({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: controller.getDateDifference(controller.active[index].startDate!,
                        controller.active[index].endDate!) +
                    1 <=
                1
            ? Colors.red.withOpacity(0.8)
            : controller.getDateDifference(controller.active[index].startDate!,
                            controller.active[index].endDate!) +
                        1 <=
                    2
                ? Colors.orangeAccent.withOpacity(0.8)
                : Colors.green.withOpacity(0.8),
        elevation: 10,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Obx(
          () => controller.isTaskUpdating.value
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text(
                              controller.active[index].title,
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
                              controller.active[index].description,
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
                                "Start Date : ${controller.active[index].startDate}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "End Date   : ${controller.active[index].endDate}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Checkbox(
                            value: controller.checkBoxValueList[index],
                            onChanged: (val) {
                              if (val!) {
                                controller.checkBoxValueList[index] = true;
                                controller.updateTaskToActive(index);
                              }
                            },
                            activeColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: const BorderSide(color: Colors.red)),
                          )
                          /*CustomCheckBox(onChange: (val) {
                      if (val!) {
                        print(val);
                      } else {
                        print(val);
                      }
                    })*/
                        ],
                      ),
                    ],
                  ),
                ),
        ));
  }
}

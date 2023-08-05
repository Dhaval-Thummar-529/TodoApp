import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/ActiveController.dart';
import 'package:todo_app/controllers/TodoController.dart';

import '../controllers/FinishedController.dart';
import '../customWidgets/customCheckBox.dart';

class Finished extends StatelessWidget {
  Finished({super.key});

  final FinishedController controller = Get.put(FinishedController());

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
                  : controller.finished.isNotEmpty
                  ? ListView.builder(
                  itemCount: controller.finished.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FinishedListTile(index: index);
                  })
                  : const Center(
                child: Text(
                  "No Finished Task!",
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

class FinishedListTile extends StatelessWidget {
  final int index;
  var controller = Get.find<FinishedController>();

  FinishedListTile({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.blue.withOpacity(0.5),
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
                      controller.finished[index].title,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: Text(
                      controller.finished[index].description,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Start Date : ${controller.finished[index].startDate}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "Finished Date : ${controller.finished[index].modifiedDate}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

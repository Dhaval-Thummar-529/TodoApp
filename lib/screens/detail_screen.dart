import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/detail_screen_controller.dart';

class DetailScreen extends StatelessWidget{
  DetailScreen({super.key});

  final DetailScreenController controller = Get.put(DetailScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Task Title"), centerTitle: true,),
      body: SingleChildScrollView(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }

}
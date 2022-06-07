import 'package:elred/app/global_widgets/date_time.dart';
import 'package:elred/app/modules/home/controllers/todo_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddToDoView extends GetView<TodoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3f4f95),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.blue,
                    ),
                    onPressed: () => Get.back(),
                  ),
                  const Text(
                    "Add New things",
                    style: TextStyle(color: Colors.blue),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.tune,
                      color: Colors.blue,
                    ),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(30)),
                  child: const Icon(
                    Icons.add,
                    size: 20,
                  ),
                  onPressed: () {},
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: controller.taskNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Cannot be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Please enter task",
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Please enter task description",
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        controller: controller.taskDesController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Cannot be empty';
                          }
                          return null;
                        },
                      ),
                    ),
                    DateSelect(
                      isReadOnly: false,
                      selectDateController: controller.selectDateController,
                      onDateChange: controller.setSelectedDate,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          textStyle: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.normal)),
                      onPressed: () async {
                        await controller.addTodo(
                            controller.taskNameController.text.trim(),
                            controller.taskDesController.text.trim(),
                            controller.selectDateController.text.trim(),
                            false,
                            "");

                        controller.taskNameController.clear();
                        controller.taskDesController.clear();
                        controller.selectDateController.clear();
                        Get.back();
                      },
                      child: const Text('Add your things'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

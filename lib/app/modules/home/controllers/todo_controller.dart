import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elred/app/data/models/task_model.dart';
import 'package:elred/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';

class TodoController extends GetxController {
  var isLoading = false;
  var taskList = <TaskModel>[];
  HomeController homeController = Get.find<HomeController>();
  final formKey = GlobalKey<FormState>();
  TextEditingController taskNameController = TextEditingController();
  TextEditingController taskDesController = TextEditingController();
  TextEditingController selectDateController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    setSelectedDate(DateTime.now());
  }

  void setSelectedDate(DateTime date) =>
      selectDateController.text = DateFormat('dd-MM-yyyy').format(date);

  Future<void> addTodo(String taskName, String taskDes, String Date, bool done,
      String id) async {

    await FirebaseFirestore.instance
        .collection('todos')
        .doc(id != '' ? id : null)
        .set(
      {
        'id': homeController.firebaseAuth.currentUser!.uid,
        'taskName': taskName,
        'taskDes': taskDes,
        'Date': Date,
        'isDone': done,
      },
      SetOptions(merge: true),
    ).then(
      (value) => getData(),
    );
  }

  Future<void> getData() async {
    try {
      QuerySnapshot _taskSnap = await FirebaseFirestore.instance
          .collection('todos')
          .orderBy('taskName')
          .get();


      taskList.clear();

      for (var item in _taskSnap.docs) {
        if (item['id'] == homeController.firebaseAuth.currentUser!.uid) {
          taskList.add(
            TaskModel(item.id, item['taskName'], item['taskDes'],
                item['Date'], item['isDone']),
          );
        }
      }
      isLoading = false;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  void deleteTask(String id) {
    FirebaseFirestore.instance.collection('todos').doc(id).delete();
  }

  void logout() async {
    await homeController.googleSign.disconnect();
    await homeController.firebaseAuth.signOut();
  }

}

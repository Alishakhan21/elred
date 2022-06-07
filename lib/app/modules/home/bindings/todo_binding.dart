import 'package:elred/app/modules/home/controllers/todo_controller.dart';
import 'package:get/get.dart';

class TodoBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TodoController>(TodoController());
  }
}

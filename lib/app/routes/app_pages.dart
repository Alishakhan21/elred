import 'package:elred/app/modules/home/bindings/todo_binding.dart';
import 'package:elred/app/modules/home/views/add_todo_view.dart';
import 'package:elred/app/modules/home/views/todo_list.dart';
import 'package:get/get.dart';
import 'package:elred/app/modules/home/bindings/home_binding.dart';
import 'package:elred/app/modules/home/bindings/login_binding.dart';
import 'package:elred/app/modules/home/views/home_view.dart';
import 'package:elred/app/modules/home/views/login_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;


  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.TODO,
      page: () => TodoView(),
      binding: TodoBinding(),
    ),
    GetPage(
      name: _Paths.ADD_TODO,
      page: () => AddToDoView(),
      binding: TodoBinding(),
    ),
  ];

}

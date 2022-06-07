import 'package:elred/app/global_widgets/date_time.dart';
import 'package:elred/app/modules/home/controllers/todo_controller.dart';
import 'package:elred/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodoView extends GetView<TodoController> {
  @override
  Widget build(BuildContext context) {
    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const SizedBox(height: 80.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Your \nThings ",
              style: TextStyle(color: Colors.white, fontSize: 23.0),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "24",
                          style: TextStyle(color: Colors.white),
                        )),
                    Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Personal",
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "15",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Bundles",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              "02-june-22",
              style: TextStyle(color: Colors.white, fontSize: 10.0),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    controller.logout();
                  },
                  child: Text(
                    "Logout",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            )
          ],
        ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: const EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: const AssetImage("images/cloud.jpg"),
                fit: BoxFit.cover,
              ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          width: MediaQuery.of(context).size.width,
          decoration:
              const BoxDecoration(color: const Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.menu, color: Colors.white),
            ),
          ),
        )
      ],
    );

    return GetBuilder<TodoController>(
      init: TodoController(),
      initState: (_) {},
      builder: (todoController) {
        todoController.getData();

        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: topContent),
              todoController.isLoading
                  ? const SizedBox(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                height: MediaQuery.of(context).size.height * 0.6,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemCount: todoController.taskList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.white,
                            child: ListTile(
                              isThreeLine: true,
                              leading: CircleAvatar(
                                child: Text(todoController.taskList[index].Date,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 5)),
                              ),
                              title: Text(
                                todoController.taskList[index].taskName,
                                style: TextStyle(color: Colors.black),
                              ),
                              subtitle: Text(
                                todoController.taskList[index].taskDes,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                              trailing: SizedBox(
                                width: 100,
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () => addTaskDialog(
                                        todoController,
                                        'Update Task',
                                        todoController.taskList[index].taskName,
                                        todoController.taskList[index].taskDes,
                                        todoController.taskList[index].Date,
                                        todoController.taskList[index].id,
                                      ),
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.black,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => todoController
                                          .deleteTask(todoController
                                              .taskList[index].id),
                                      icon: const Icon(Icons.delete),
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            foregroundColor: Colors.blueAccent,
            child: const Icon(Icons.add),
            onPressed: () {
              Get.toNamed(
                Routes.ADD_TODO,

              );
            },
          ),
        );
      },
    );
  }

  addTaskDialog(TodoController todoController, String title, String taskName,
      String taskDes, String date, String id) async {
    if (taskName.isNotEmpty) {
      controller.taskNameController.text = taskName;
      controller.taskDesController.text = taskDes;
      controller.selectDateController.text = date;
    }
    Get.defaultDialog(
      title: title,
      content: Form(
        key: controller.formKey,
        child: Column(
          children: [
            TextFormField(
              controller: controller.taskNameController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Cannot be empty';
                }
                return null;
              },
            ),
            TextFormField(
              controller: controller.taskDesController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Cannot be empty';
                }
                return null;
              },
            ),
            DateSelect(
              isReadOnly: false,
              selectDateController: controller.selectDateController,
              onDateChange: controller.setSelectedDate,
            ),
            ElevatedButton(
              onPressed: () async {
                await todoController.addTodo(
                    controller.taskNameController.text.trim(),
                    controller.taskDesController.text.trim(),
                    controller.selectDateController.text.trim(),
                    false,
                    id);

                controller.taskNameController.clear();
                controller.taskDesController.clear();
                controller.selectDateController.clear();
                Get.back();
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

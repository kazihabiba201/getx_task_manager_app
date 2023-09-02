import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_task_manage_app/data/model/task_list_model.dart';
import 'package:getx_task_manage_app/data/utility/urls.dart';

import 'package:getx_task_manage_app/ui/screens/state_manage_controllers/delete_task_c.dart';
import 'package:getx_task_manage_app/ui/screens/state_manage_controllers/get_task_c.dart';
import 'package:getx_task_manage_app/ui/screens/task_screens/update_task_status.dart';
import 'package:getx_task_manage_app/ui/widgets/screen_background.dart';
import 'package:getx_task_manage_app/ui/widgets/task_list_tile.dart';
import 'package:getx_task_manage_app/ui/widgets/user_profile_appbar.dart';


class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({Key? key}) : super(key: key);

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  final GetTasksController _getTasksController = Get.find<GetTasksController>();
  final DeleteTaskController _deleteTaskController =
  Get.find<DeleteTaskController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getTasksController.getTasks(Urls.completedTasks).then((value) {
        if (value == false) {
          Get.snackbar(
            'Failed',
            'Completed task data get failed!',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            borderRadius: 10,
          );
        }
      });
    });
  }

  void showStatusUpdateBottomSheet(TaskData task) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return UpdateTaskStatusSheet(
            task: task,
            onUpdate: () {
              Get.back();
              _getTasksController.getTasks(Urls.completedTasks);
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScreenBackground(
          child: Column(
            children: [
              const UserProfileAppBar(),
              Expanded(
                child: GetBuilder<GetTasksController>(
                    builder: (getTasksController) {
                      return getTasksController.getTaskInProgress
                          ? const Center(
                        child: CircularProgressIndicator(),
                      )
                          : ListView.separated(
                        itemCount:
                        getTasksController.taskListModel.data?.length ??
                            0,
                        itemBuilder: (context, index) {
                          return TaskListTile(
                            data:
                            getTasksController.taskListModel.data![index],
                            onDeleteTap: () {
                              deleteAlertDialogue(index);
                              //deleteTask(_taskListModel.data![index].sId!);
                            },
                            onEditTap: () {
                              editAlertDialogue(index);
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                            height: 4,
                          );
                        },
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void deleteAlertDialogue(int index) {
    Get.dialog(
      AlertDialog(
        title: const Text(
          'Delete Alert',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          "Are you want to delete this item?",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              _deleteTaskController
                  .deleteTask(
                  _getTasksController.taskListModel.data![index].sId!)
                  .then((value) {
                _getTasksController.getUpdateState();
                if (value) {
                  Get.snackbar(
                    'Success',
                    'Task deletion successful!',
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                    borderRadius: 8,
                  );
                } else {
                  Get.snackbar(
                    'Failed',
                    'Task deletion failed!',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                    borderRadius: 8,
                  );
                }
              });
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  void editAlertDialogue(int index) {
    Get.dialog(
      AlertDialog(
        title: const Text(
          'Edit Alert',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          "Are you want to edit status of this item?",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              showStatusUpdateBottomSheet(
                  _getTasksController.taskListModel.data![index]);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_task_manage_app/data/model/task_list_model.dart';
import 'package:getx_task_manage_app/data/utility/urls.dart';
import 'package:getx_task_manage_app/ui/screens/state_manage_controllers/delete_task_c.dart';
import 'package:getx_task_manage_app/ui/screens/state_manage_controllers/get_task_c.dart';
import 'package:getx_task_manage_app/ui/screens/state_manage_controllers/summary_count_c.dart';
import 'package:getx_task_manage_app/ui/screens/task_screens/add_new_task_screen.dart';
import 'package:getx_task_manage_app/ui/screens/task_screens/update_task_status.dart';
import 'package:getx_task_manage_app/ui/widgets/screen_background.dart';
import 'package:getx_task_manage_app/ui/widgets/summary_card.dart';
import 'package:getx_task_manage_app/ui/widgets/task_list_tile.dart';
import 'package:getx_task_manage_app/ui/widgets/user_profile_appbar.dart';


class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final SummaryCountController _summaryCountController =
  Get.find<SummaryCountController>();
  final GetTasksController _getTasksController = Get.find<GetTasksController>();
  final DeleteTaskController _deleteTaskController =
  Get.find<DeleteTaskController>();

  @override
  void initState() {
    super.initState();
    // after widget binding
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _summaryCountController.getCountSummary().then((value) {
        if (value == false) {
          Get.snackbar(
            'Failed',
            'Summary data get failed!',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            borderRadius: 10,
          );
        }
      });
      _getTasksController.getTasks(Urls.newTasks).then((value) {
        if (value == false) {
          Get.snackbar(
            'Failed',
            'New task data get failed!',
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
              _summaryCountController.getCountSummary();
              _getTasksController.getTasks(Urls.newTasks);
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
              GetBuilder<SummaryCountController>(
                  builder: (summaryCountController) {
                    return summaryCountController.getCountSummaryInProgress
                        ? const LinearProgressIndicator()
                        : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 80,
                        width: double.infinity,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: summaryCountController
                              .summaryCountModel.data?.length ??
                              0,
                          itemBuilder: (context, index) {
                            return SummaryCard(
                              title: summaryCountController
                                  .summaryCountModel.data![index].sId ??
                                  'New',
                              number: summaryCountController
                                  .summaryCountModel.data![index].sum ??
                                  0,
                            );
                          },
                          separatorBuilder:
                              (BuildContext context, int index) {
                            return const Divider(
                              height: 4,
                            );
                          },
                        ),
                      ),
                    );
                  }),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    _summaryCountController.getCountSummary().then((value) {
                      if (value == false) {
                        Get.snackbar(
                          'Failed',
                          'Summary data get failed!',
                          backgroundColor: Colors.redAccent,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM,
                          borderRadius: 8,
                        );
                      }
                    });
                    _getTasksController.getTasks(Urls.newTasks).then((value) {
                      if (value == false) {
                        Get.snackbar(
                          'Failed',
                          'New task data get failed!',
                          backgroundColor: Colors.redAccent,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM,
                          borderRadius: 8,
                        );
                      }
                    });
                  },
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
                              data: getTasksController
                                  .taskListModel.data![index],
                              onDeleteTap: () {
                                deleteAlertDialogue(index);
                                //deleteTask(_taskListModel.data![index].sId!);
                              },
                              onEditTap: () {
                                editAlertDialogue(index);
                              },
                            );
                          },
                          separatorBuilder:
                              (BuildContext context, int index) {
                            return const Divider(
                              height: 4,
                            );
                          },
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddNewTaskScreen()));
        },
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
                _summaryCountController.getCountSummary();
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
                    backgroundColor: Colors.redAccent,
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_task_manage_app/data/model/task_list_model.dart';
import 'package:getx_task_manage_app/ui/screens/state_manage_controllers/update_task_status_c.dart';


class UpdateTaskStatusSheet extends StatefulWidget {
  final TaskData task;
  final VoidCallback onUpdate;

  const UpdateTaskStatusSheet(
      {Key? key, required this.task, required this.onUpdate})
      : super(key: key);

  @override
  State<UpdateTaskStatusSheet> createState() => _UpdateTaskStatusSheetState();
}

class _UpdateTaskStatusSheetState extends State<UpdateTaskStatusSheet> {
  List<String> taskStatusList = ['New', 'Progress', 'Cancelled', 'Completed'];
  late String _selectedTask;

  @override
  void initState() {
    _selectedTask = widget.task.status!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: GetBuilder<UpdateTaskStatusController>(
          builder: (updateTaskStatusController) {
            return Column(
              children: [
                const Padding(
                    padding: EdgeInsets.all(16), child: Text('Update Status')),
                Expanded(
                  child: ListView.builder(
                    itemCount: taskStatusList.length,
                    itemBuilder: (context, index) {
                      bool isSelected = _selectedTask == taskStatusList[index];
                      return Container(
                        color: isSelected ? Colors.green : Colors.transparent,
                        child: ListTile(
                          onTap: () {
                            _selectedTask = taskStatusList[index];
                            updateTaskStatusController.getUpdateState();
                          },
                          title: Text(taskStatusList[index].toUpperCase(), style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black, // Change color here
                          ),),
                          trailing: isSelected
                              ? const Icon(Icons.check, color: Colors.white)
                              : null,
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(16),
                    child: Visibility(
                        visible: updateTaskStatusController.updateTaskInProgress ==
                            false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                            onPressed: () {
                              updateTaskStatusController
                                  .updateTask(widget.task.sId!, _selectedTask)
                                  .then((value) {
                                widget.onUpdate();
                                if (value) {
                                  Get.snackbar(
                                    'Success',
                                    'Update task status successful!',
                                    backgroundColor: Colors.green,
                                    colorText: Colors.white,
                                    snackPosition: SnackPosition.BOTTOM,
                                    borderRadius: 8,
                                  );
                                } else {
                                  Get.snackbar(
                                    'Failed',
                                    'Update task status has been failed!',
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                    snackPosition: SnackPosition.BOTTOM,
                                    borderRadius: 8,
                                  );
                                }
                              });
                            },
                            child: const Text('Update'))))
              ],
            );
          }),
    );
  }
}

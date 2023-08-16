import 'package:get/get.dart';
import 'package:getx_task_manage_app/data/model/network_response.dart';
import 'package:getx_task_manage_app/data/model/task_list_model.dart';
import 'package:getx_task_manage_app/data/services/network_celler.dart';


class GetTasksController extends GetxController {
  bool _getTaskInProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  void getUpdateState() {
    update();
  }

  bool get getTaskInProgress => _getTaskInProgress;

  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getTasks(String url) async {
    _getTaskInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller().getRequest(url);
    _getTaskInProgress = false;
    update();
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);
      update();
      return true;
    } else {
      return false;
    }
  }
}

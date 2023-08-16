import 'package:get/get.dart';
import 'package:getx_task_manage_app/data/model/network_response.dart';
import 'package:getx_task_manage_app/data/services/network_celler.dart';
import 'package:getx_task_manage_app/data/utility/urls.dart';
import 'package:getx_task_manage_app/ui/screens/state_manage_controllers/get_task_c.dart';


class DeleteTaskController extends GetxController {
  final GetTasksController _getTasksController = Get.find<GetTasksController>();

  Future<bool> deleteTask(String taskId) async {
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.deleteTask(taskId));
    update();
    if (response.isSuccess) {
      _getTasksController.taskListModel.data!
          .removeWhere((element) => element.sId == taskId);
      update();
      return true;
    } else {
      return false;
    }
  }
}

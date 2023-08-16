import 'package:get/get.dart';
import 'package:getx_task_manage_app/data/model/network_response.dart';
import 'package:getx_task_manage_app/data/services/network_celler.dart';
import 'package:getx_task_manage_app/data/utility/urls.dart';

class AddNewTaskController extends GetxController {
  bool _adNewTaskInProgress = false;

  bool get adNewTaskInProgress => _adNewTaskInProgress;

  Future<bool> addNewTask(String title, String description) async {
    _adNewTaskInProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "title": title,
      "description": description,
      "status": "New"
    };
    final NetworkResponse response =
    await NetworkCaller().postRequest(Urls.createTask, requestBody);
    _adNewTaskInProgress = false;
    update();
    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }
}

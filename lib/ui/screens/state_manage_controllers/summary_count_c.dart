import 'package:get/get.dart';
import 'package:getx_task_manage_app/data/model/network_response.dart';
import 'package:getx_task_manage_app/data/model/summary_count_model.dart';
import 'package:getx_task_manage_app/data/services/network_celler.dart';
import 'package:getx_task_manage_app/data/utility/urls.dart';


class SummaryCountController extends GetxController {
  bool _getCountSummaryInProgress = false;
  SummaryCountModel _summaryCountModel = SummaryCountModel();

  bool get getCountSummaryInProgress => _getCountSummaryInProgress;

  SummaryCountModel get summaryCountModel => _summaryCountModel;

  Future<bool> getCountSummary() async {
    _getCountSummaryInProgress = true;
    update();
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.taskStatusCount);
    _getCountSummaryInProgress = false;
    update();
    if (response.isSuccess) {
      _summaryCountModel = SummaryCountModel.fromJson(response.body!);
      return true;
    } else {
      return false;
    }
  }
}

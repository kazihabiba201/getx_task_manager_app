import 'package:get/get.dart';
import 'package:getx_task_manage_app/data/model/network_response.dart';
import 'package:getx_task_manage_app/data/services/network_celler.dart';
import 'package:getx_task_manage_app/data/utility/urls.dart';


class EmailVerificationController extends GetxController {
  bool _emailVerificationInProgress = false;

  bool get emailVerificationInProgress => _emailVerificationInProgress;

  Future<bool> sendOTPToEmail(String email) async {
    _emailVerificationInProgress = true;
    update();
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.sendOtpToEmail(email));
    _emailVerificationInProgress = false;
    update();
    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }
}

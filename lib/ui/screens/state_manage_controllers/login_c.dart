import 'package:get/get.dart';
import 'package:getx_task_manage_app/data/model/login_model.dart';
import 'package:getx_task_manage_app/data/model/network_response.dart';
import 'package:getx_task_manage_app/data/services/network_celler.dart';
import 'package:getx_task_manage_app/data/utility/urls.dart';
import 'package:getx_task_manage_app/ui/utility/auth_utility.dart';


class LoginController extends GetxController {
  bool _loginInProgress = false;

  bool get loginInProgress => _loginInProgress;

  Future<bool> login(String email, String password) async {
    _loginInProgress = true;
    update();
    Map<String, dynamic> requestBody = {"email": email, "password": password};
    final NetworkResponse response = await NetworkCaller()
        .postRequest(Urls.login, requestBody, isLogin: true);
    _loginInProgress = false;
    update();
    if (response.isSuccess) {
      LoginModel model = LoginModel.fromJson(response.body!);
      await AuthUtility.saveUserInfo(model);
      return true;
    } else {
      return false;
    }
  }
}

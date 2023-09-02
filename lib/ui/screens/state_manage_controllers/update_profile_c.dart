import 'package:get/get.dart';
import 'package:getx_task_manage_app/data/model/login_model.dart';
import 'package:getx_task_manage_app/data/model/network_response.dart';
import 'package:getx_task_manage_app/data/services/network_celler.dart';
import 'package:getx_task_manage_app/data/utility/urls.dart';
import 'package:getx_task_manage_app/ui/utility/auth_utility.dart';


class UpdateProfileController extends GetxController {
  bool _profileUpdateInProgress = false;

  bool get profileUpdateInProgress => _profileUpdateInProgress;

  void getUpdateState() {
    update();
  }

  Future<bool> updateProfile(
      String firstName, String lastName, String mobile, String password) async {
    _profileUpdateInProgress = true;
    update();
    final Map<String, dynamic> requestBody = {
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "photo": "",
      "password":password,
    };
    if (password.isNotEmpty && password.length <= 6) {
      requestBody['password'] = password;
    }

    final NetworkResponse response =
    await NetworkCaller().postRequest(Urls.profileUpdate, requestBody);
    _profileUpdateInProgress = false;
    update();
    if (response.isSuccess) {
      UserData userData = AuthUtility.userInfo.data!;
      userData.firstName = firstName;
      userData.lastName = lastName;
      userData.mobile = mobile;
      userData.password = password;
      AuthUtility.updateUserInfo(userData);
      return true;
    } else {
      return false;
    }
  }
}

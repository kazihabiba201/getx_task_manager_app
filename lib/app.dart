import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_task_manage_app/ui/screens/state_manage_controllers/add_new_task_controller.dart';
import 'package:getx_task_manage_app/ui/screens/state_manage_controllers/bottom_nav_c.dart';
import 'package:getx_task_manage_app/ui/screens/state_manage_controllers/delete_task_c.dart';
import 'package:getx_task_manage_app/ui/screens/state_manage_controllers/email_verification_c.dart';
import 'package:getx_task_manage_app/ui/screens/state_manage_controllers/get_task_c.dart';
import 'package:getx_task_manage_app/ui/screens/state_manage_controllers/login_c.dart';
import 'package:getx_task_manage_app/ui/screens/state_manage_controllers/otp_verification_c.dart';
import 'package:getx_task_manage_app/ui/screens/state_manage_controllers/reset_password_c.dart';
import 'package:getx_task_manage_app/ui/screens/state_manage_controllers/signup_c.dart';
import 'package:getx_task_manage_app/ui/screens/state_manage_controllers/summary_count_c.dart';
import 'package:getx_task_manage_app/ui/screens/state_manage_controllers/update_profile_c.dart';
import 'package:getx_task_manage_app/ui/screens/state_manage_controllers/update_task_status_c.dart';
import 'package:getx_task_manage_app/ui/screens/task_screens/splash_screen.dart';


class TaskManagerApp extends StatefulWidget {
  static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

  const TaskManagerApp({Key? key}) : super(key: key);

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: TaskManagerApp.globalKey,
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.green,
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.6),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepOrange,
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.6),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      initialBinding: ControllerBinding(),
      themeMode: ThemeMode.light,
      home: const SplashScreen(),
    );
  }
}

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(OtpVerificationController());
    Get.put(ResetPasswordController());
    Get.put(SignupController());
    Get.put(EmailVerificationController());
    Get.put(AddNewTaskController());
    Get.put(SummaryCountController());
    Get.put(GetTasksController());
    Get.put(DeleteTaskController());
    Get.put(UpdateTaskStatusController());
    Get.put(BottomNavController());
    Get.put(UpdateProfileController());
  }
}

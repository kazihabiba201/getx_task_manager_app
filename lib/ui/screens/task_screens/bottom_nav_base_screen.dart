import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_task_manage_app/ui/screens/state_manage_controllers/bottom_nav_c.dart';
import 'package:getx_task_manage_app/ui/screens/task_screens/cancelled_task_screen.dart';
import 'package:getx_task_manage_app/ui/screens/task_screens/completed_task.dart';
import 'package:getx_task_manage_app/ui/screens/task_screens/in_progress_task.dart';
import 'package:getx_task_manage_app/ui/screens/task_screens/new_task.dart';


class BottomNavBaseScreen extends StatelessWidget {
  BottomNavBaseScreen({super.key});

  final RxInt _selectedScreenIndex = 0.obs;
  final List<Widget> _screens = const [
    NewTaskScreen(),
    InProgressTaskScreen(),
    CancelledTaskScreen(),
    CompletedTaskScreen()
  ];

  @override
  Widget build(BuildContext context) {
    print(_selectedScreenIndex.value);
    return Scaffold(
      body: Obx(() => _screens[_selectedScreenIndex.value]),
      bottomNavigationBar:
      GetBuilder<BottomNavController>(builder: (bottomNavController) {
        return BottomNavigationBar(
          currentIndex: _selectedScreenIndex.value,
          unselectedItemColor: Colors.grey,
          unselectedLabelStyle: const TextStyle(color: Colors.grey),
          showUnselectedLabels: true,
          selectedItemColor: Colors.green,
          onTap: (int index) {
            _selectedScreenIndex.value = index;
            bottomNavController.getUpdateState();
            print(_selectedScreenIndex.value);
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: 'New'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_tree), label: 'In Progress'),
            BottomNavigationBarItem(
                icon: Icon(Icons.cancel_outlined), label: 'Cancel'),
            BottomNavigationBarItem(
                icon: Icon(Icons.done_all), label: 'Completed'),
          ],
        );
      }),
    );
  }
}

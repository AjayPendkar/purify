import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purify/features/profile/views/profile_screen.dart';
import '../../../core/constants/app_colors.dart';
import '../../home/views/home_screen.dart';
import '../../courses/views/course_tab_screen.dart';
import '../controllers/main_navigation_controller.dart';

class MainNavigationScreen extends GetView<MainNavigationController> {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.selectedIndex.value != 0) {
          controller.changePage(0);
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: Obx(() => IndexedStack(
          index: controller.selectedIndex.value,
          children: [
            HomeScreen(userName: controller.userName),
            CourseTabScreen(userName: controller.userName),
            const Center(child: Text('Learn')),
            ProfileScreen()
          ],
        )),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.selectedIndex.value,
            onTap: controller.changePage,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.play_circle),
                label: 'Learn',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
} 
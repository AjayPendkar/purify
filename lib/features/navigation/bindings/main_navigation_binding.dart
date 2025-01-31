import 'package:get/get.dart';
import '../controllers/main_navigation_controller.dart';
import '../../auth/services/auth_service.dart';
import '../../courses/controllers/course_controller.dart';

class MainNavigationBinding implements Bindings {
  @override
  void dependencies() {
    // Make sure AuthService is available
    if (!Get.isRegistered<AuthService>()) {
      Get.put(Get.find<AuthService>());
    }

    // Put MainNavigationController immediately
    Get.put(
      MainNavigationController(
        authService: Get.find<AuthService>(),
      ),
      permanent: true, // Keep instance alive
    );

    // Add CourseController
    Get.put(
      CourseController(),
      permanent: true,
    );
  }
} 
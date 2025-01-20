import 'package:get/get.dart';
import '../../auth/views/login_screen.dart';

class OnboardController extends GetxController {
  void navigateToLogin() {
    Get.to(() => const LoginScreen());
  }

  void getStarted() {
    // Add any initialization logic here
    Get.offAll(() => const LoginScreen());
  }
} 
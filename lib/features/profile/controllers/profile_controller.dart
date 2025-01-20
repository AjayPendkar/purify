import 'package:get/get.dart';
import '../../auth/controllers/auth_controller.dart';

class ProfileController extends GetxController {
  final AuthController _authController = Get.find();

  void onPersonalizedHealthTap() {
    // Handle personalized health tap
  }

  void onNotificationsTap() {
    // Handle notifications tap
  }

  void onAccountSettingsTap() {
    // Handle account settings tap
  }

  void onAppPreferencesTap() {
    // Handle app preferences tap
  }

  void onLegalSupportTap() {
    // Handle legal & support tap
  }

  void onLogoutTap() {
    _authController.logout();
  }
} 
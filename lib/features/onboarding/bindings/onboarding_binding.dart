import 'package:get/get.dart';
import '../controllers/onboarding_controller.dart';
import '../../auth/services/auth_service.dart';
import '../../auth/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    // Make sure dependencies are available
    if (!Get.isRegistered<AuthRepository>()) {
      Get.put(Get.find<AuthRepository>());
    }
    if (!Get.isRegistered<AuthService>()) {
      Get.put(Get.find<AuthService>());
    }

    // Put the controller
    Get.put(OnboardingController(
      authRepo: Get.find<AuthRepository>(),
      authService: Get.find<AuthService>(),
      prefs: Get.find<SharedPreferences>(),
    ));
  }
} 
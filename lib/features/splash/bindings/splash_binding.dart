import 'package:get/get.dart';
import '../controllers/splash_controller.dart';
import '../../auth/services/auth_service.dart';
import '../../auth/controllers/auth_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController(
      authService: Get.find<AuthService>(),
      authController: Get.find<AuthController>(),
    ));
  }
} 
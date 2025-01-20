import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../services/auth_service.dart';
import '../repositories/auth_repository.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController(
      authService: Get.find<AuthService>(),
      authRepo: Get.find<AuthRepository>(),
    ));
  }
} 
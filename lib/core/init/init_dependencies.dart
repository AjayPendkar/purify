import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/auth/services/auth_service.dart';
import '../../features/auth/repositories/auth_repository.dart';
import '../../features/auth/controllers/auth_controller.dart';
import '../../features/navigation/controllers/main_navigation_controller.dart';
import '../../features/splash/controllers/splash_controller.dart';
import '../api/api_client.dart';
import '../config/app_config.dart';
import '../services/connectivity_service.dart';

Future<void> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences, fenix: true);

  // Services - Put this first before other services
  Get.put(ConnectivityService(), permanent: true);

  // API Client
  Get.lazyPut(() => ApiClient(
    baseUrl: AppConfig.instance.baseUrl,
    sharedPreferences: Get.find(),
  ), fenix: true);

  // Repositories
  Get.lazyPut(() => AuthRepository(
    apiClient: Get.find(),
  ), fenix: true);

  // Services
  Get.lazyPut(() => AuthService(
    authRepository: Get.find(),
    prefs: Get.find(),
  ), fenix: true);

  // Controllers
  Get.lazyPut(() => AuthController(
    authService: Get.find(),
    authRepo: Get.find(),
  ), fenix: true);

  Get.lazyPut(() => MainNavigationController(
    authService: Get.find(),
  ), fenix: true);

  Get.lazyPut(() => SplashController(
    authService: Get.find(),
    authController: Get.find(),
  ), fenix: true);
} 
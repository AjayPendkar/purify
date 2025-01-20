import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/api_client.dart';
import '../../features/auth/repositories/auth_repository.dart';
import '../../features/auth/services/auth_service.dart';
import '../../features/auth/controllers/auth_controller.dart';
import '../config/app_config.dart';
import '../services/connectivity_service.dart';
import '../../features/profile/controllers/profile_controller.dart';

class InitialBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    // Initialize SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    Get.put<SharedPreferences>(prefs, permanent: true);
    
    // API Client
    Get.lazyPut(() => ApiClient(
      baseUrl: AppConfig.instance.baseUrl,
      sharedPreferences: prefs,
    ), fenix: true);

    // Repositories
    Get.lazyPut(() => AuthRepository(
      apiClient: Get.find(),
    ), fenix: true);

    // Services
    Get.lazyPut(() => AuthService(
      authRepository: Get.find(),
      prefs: prefs,
    ), fenix: true);

    // Controllers
    Get.lazyPut(() => AuthController(
      authService: Get.find(),
      authRepo: Get.find(),
    ), fenix: true);

    // Add ProfileController
    Get.lazyPut(() => ProfileController(), fenix: true);

    // Initialize ConnectivityService
    Get.put(ConnectivityService(), permanent: true);
  }
} 
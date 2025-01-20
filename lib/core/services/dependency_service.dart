import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/api_client.dart';
import '../config/app_config.dart';
import '../../features/auth/repositories/auth_repository.dart';

class DependencyService extends GetxService {
  Future<DependencyService> init() async {
    try {
      // Initialize SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      Get.put<SharedPreferences>(prefs, permanent: true);

      // Initialize API Client
      Get.put<ApiClient>(
        ApiClient(
          baseUrl: AppConfig.instance.baseUrl,
          sharedPreferences: prefs,
        ),
        permanent: true,
      );

      // Initialize Repositories
      Get.put<AuthRepository>(
        AuthRepository(
          apiClient: Get.find<ApiClient>(),
        ),
        permanent: true,
      );

      return this;
    } catch (e) {
      print('Error initializing dependencies: $e');
      rethrow;
    }
  }
} 
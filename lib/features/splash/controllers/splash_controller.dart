import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../auth/services/auth_service.dart';
import '../../../core/routes/route_helper.dart';

class SplashController extends GetxController {
  final AuthService _authService;
  final AuthController _authController;
  final _storage = GetStorage();
  static const String FIRST_TIME_KEY = 'is_first_time';

  SplashController({
    required AuthService authService,
    required AuthController authController,
  })  : _authService = authService,
        _authController = authController;

  Future<void> initializeApp() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      
      final isFirstTime = !(_storage.read(FIRST_TIME_KEY) ?? false);
      final isAuthenticated = await _authService.checkAuth();
      
      if (isFirstTime) {
        // First time app launch - show onboarding
        await _storage.write(FIRST_TIME_KEY, true);
        Get.offAllNamed(RouteHelper.getWellcomeToPurifyRoute());
        return;
      }
      
      if (isAuthenticated) {
        final user = _authService.currentUser.value;
        if (user != null) {
          if (user.isProfileComplete) {
            Get.offAllNamed(RouteHelper.getMainNavigationRoute());
          } else {
            Get.offAllNamed(RouteHelper.getUserInfoRoute());
          }
        }
      } else {
        // Not first time but not authenticated - go to login
        Get.offAllNamed(RouteHelper.getLoginRoute());
      }
    } catch (e) {
      debugPrint('App initialization error: $e');
      Get.offAllNamed(RouteHelper.getLoginRoute());
    }
  }
} 
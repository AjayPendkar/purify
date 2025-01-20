import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../auth/views/login_screen.dart';
import '../views/onboarding_screen.dart';

class WelcomeController extends GetxController {
  void navigateToLogin() {
    Get.to(() => const LoginScreen());
  }

  void getStarted() {
    Get.to(() => const OnboardingScreen());
  }
} 
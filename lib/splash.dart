// ignore_for_file: unused_import

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:purify/core/widgets/universal_image.dart';
import 'package:purify/features/auth/views/login_screen.dart';
import 'package:purify/features/onboarding/views/user_info_screen.dart';
import 'features/onboard/views/welcome_to_purify_screen.dart';
import 'features/auth/services/auth_service.dart';
import 'features/home/views/home_screen.dart';
import 'features/splash/controllers/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<SplashController>().initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E4F4F),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/logo.svg',
              height: 120,
              width: 120,
            ),
            const SizedBox(height: 20),
            const Text(
              'Purify',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

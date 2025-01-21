import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purify/core/routes/route_helper.dart';
import 'package:purify/features/navigation/views/main_navigation_screen.dart';
import 'package:purify/features/onboarding/views/user_info_screen.dart';
import '../../../core/widgets/toast_message.dart';
import '../repositories/auth_repository.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../models/auth_response_model.dart';
import 'package:purify/core/services/google_sheets_service.dart';
import 'package:purify/features/onboarding/bindings/onboarding_binding.dart';
import 'package:purify/features/navigation/bindings/main_navigation_binding.dart';

class OtpController extends GetxController {
  final AuthRepository authRepository;
  final AuthService authService;
  final String phoneNumber;

  final List<TextEditingController> otpControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  
  bool isLoading = false;

  //------------------------ Added Mock Implementation ------------------------
  static const _mockVerifyOtpResponse = {
    "data": {
      "token": "eyJhbGciOiJIUzI1NiJ9...",
      "user": {
        "id": "uuid",
        "phone": "9346715157",
        "name": "User Name",
        "email": "user@example.com"
      } 
    },
    "message": "OTP verified successfully",
    "status": "SUCCESS"
  };

  String get otp => otpControllers.map((e) => e.text).join();

  OtpController({
    required this.authRepository,
    required this.authService,
    required this.phoneNumber,
  });

  @override
  void onInit() {
    super.onInit();
    // Save phone number when OTP screen is initialized
    authService.savePhone(phoneNumber);
    for (var controller in otpControllers) {
      controller.addListener(_checkAndVerifyOtp);
    }
  }

  void _checkAndVerifyOtp() {
    if (otp.length == 4 && otpControllers.every((c) => c.text.isNotEmpty)) {
      verifyOtp();
    }
  }

  Future<void> verifyOtp() async {
    try {
      isLoading = true;
      update();

      final phone = phoneNumber; // Use phoneNumber directly
      
      // Mock OTP verification
      await Future.delayed(const Duration(seconds: 1));

      // Check if phone is registered
      final isRegistered = await GoogleSheetsService.isPhoneRegistered(phone);
      if (!isRegistered) {
        // New user - register in sheets
        await GoogleSheetsService.registerNewUser(phone);
        // Navigate to onboarding with binding
        Get.off(() => const UserInfoScreen(), binding: OnboardingBinding());
        return;
      }

      // Get existing user data
      final existingUser = await GoogleSheetsService.getUserByPhone(phone);
      if (existingUser != null && 
          existingUser['name'].isNotEmpty && 
          existingUser['gender'].isNotEmpty && 
          existingUser['dob'].isNotEmpty && 
          existingUser['healthIssues'].isNotEmpty) {
        // Profile complete - go to main screen with binding
        Get.offAll(() => const MainNavigationScreen(), 
          binding: MainNavigationBinding()
        );
      } else {
        // Profile incomplete - go to onboarding
        Get.off(() => const UserInfoScreen(), 
          binding: OnboardingBinding()
        );
      }

    } catch (e) {
      debugPrint('Error verifying OTP: $e');
      Get.snackbar('Error', 'Something went wrong');
    } finally {
      isLoading = false;
      update();
    }
  }
  //------------------------End Added Code ------------------------

  Future<void> resendOtp({required bool isSMS}) async {
    try {
      final response = await authRepository.sendOtp(phoneNumber);
      
      if (response.statusCode == 200 && response.body != null) {
        final otpResponse = SendOtpResponse.fromJson(response.body as Map<String, dynamic>);
        ToastMessage.show(otpResponse.message);
      } else {
        ToastMessage.show('Failed to send OTP', isError: true);
      }
    } catch (e) {
      debugPrint('Resend OTP error: $e');
      ToastMessage.show('Failed to send OTP', isError: true);
    }
  }

  @override
  void onClose() {
    for (var controller in otpControllers) {
      controller.removeListener(_checkAndVerifyOtp);
      controller.dispose();
    }
    super.onClose();
  }
}

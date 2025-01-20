import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purify/core/routes/route_helper.dart';
import '../../../core/widgets/toast_message.dart';
import '../repositories/auth_repository.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../models/auth_response_model.dart';

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
    for (var controller in otpControllers) {
      controller.addListener(_checkAndVerifyOtp);
    }
  }

  void _checkAndVerifyOtp() {
    if (otp.length == 4 && otpControllers.every((c) => c.text.isNotEmpty)) {
      verifyOtp(phoneNumber, otp: otp);
    }
  }

  Future<void> verifyOtp(String phone, {String? otp}) async {
    if (otp == null || otp.length != 4) {
      Get.snackbar('Error', 'Please enter complete OTP');
      return;
    }

    isLoading = true;
    update();

    try {
      /* Original Implementation
      final response = await authRepository.verifyOtp(phone, otp);
      
      if (response.statusCode == 200 && response.body != null) {
        final authResponse = response.body!;
        
        if (!authResponse.success) {
          Get.snackbar('Error', authResponse.message);
          return;
        }

        debugPrint('Token from response: ${authResponse.data.token}');

        final user = UserModel(
          token: authResponse.data.token,
          phone: phone,
          isProfileComplete: !authResponse.data.newUser
        );
        await authService.saveUserAndToken(user);

        if (authResponse.data.newUser) {
          Get.offAllNamed(RouteHelper.getUserInfoRoute());
          return;
        }

        // Check profile completion
        final profileResponse = await authRepository.getUserProfile();
        if (profileResponse.statusCode == 200 && profileResponse.body != null) {
          final userData = (profileResponse.body as Map<String, dynamic>)['data'];
          final userProfile = UserModel.fromJson(userData);
          
          Get.offAllNamed(
            userProfile.isProfileComplete 
              ? RouteHelper.getMainNavigationRoute()
              : RouteHelper.getUserInfoRoute()
          );
        } else {
          Get.offAllNamed(RouteHelper.getUserInfoRoute());
        }
      } else {
        Get.snackbar('Error', 'Invalid OTP');
      }
      */

      // Mock Implementation
      await Future.delayed(const Duration(seconds: 1)); // Simulate API delay
      
      final mockResponse = _mockVerifyOtpResponse;
      
      if (mockResponse['status'] == 'SUCCESS') {
        final userData = mockResponse['data'] as Map<String, dynamic>;
        
        final user = UserModel(
          token: userData['token'],
          phone: userData['user']['phone'],
          isProfileComplete: true  // For testing, set as complete
        );
        
        await authService.saveUserAndToken(user);
        
        Get.snackbar(
          'Success',
          mockResponse['message'] as String,
          snackPosition: SnackPosition.BOTTOM,
        );

        // Navigate to main screen
        Get.offAllNamed(RouteHelper.getMainNavigationRoute());
      } else {
        Get.snackbar('Error', 'Invalid OTP');
      }
      
    } catch (e) {
      debugPrint('OTP verification error: $e');
      Get.snackbar('Error', 'Failed to verify OTP');
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

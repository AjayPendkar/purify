import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purify/core/routes/route_helper.dart';
import '../repositories/auth_repository.dart';
import '../views/otp_verification_screen.dart';
import '../models/auth_response_model.dart';

class LoginController extends GetxController {
  late final AuthRepository authRepository;
  final phoneController = TextEditingController();
  bool _isLoading = false;
  
  LoginController();

  bool get isLoading => _isLoading;
  
  bool get isPhoneValid {
    final phone = phoneController.text;
    final regex = RegExp(r'^[6-9]\d{9}$');
    return regex.hasMatch(phone);
  }

  void setLoading(bool val) {
    _isLoading = val;
    update();
  }

  void onPhoneChanged() {
    update();
  }

  @override
  void onInit() {
    super.onInit();
    authRepository = Get.find<AuthRepository>();
    phoneController.addListener(onPhoneChanged);
  }

  //------------------------ Added Mock Implementation ------------------------
  static const _mockOtpResponse = {
    "timestamp": "1735137078.381110100",
    "status": 200,
    "message": "OTP sent successfully",
    "data": "OTP sent successfully",
    "success": true
  };

  Future<void> login() async {
    if (!isPhoneValid) return;

    setLoading(true);

    try {
      /* Original Implementation
      final response = await authRepository.sendOtp(phoneController.text);
      if (response.statusCode == 200 && response.body != null) {
        Get.toNamed(
          RouteHelper.getOtpRoute(),
          arguments: phoneController.text,
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to send OTP',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      */

      // Mock Implementation
      await Future.delayed(const Duration(seconds: 1)); // Simulate API delay
      final response = SendOtpResponse.fromJson(_mockOtpResponse);
      
      if (response.success) {
        Get.toNamed(
          RouteHelper.getOtpRoute(),
          arguments: phoneController.text,
        );
         Get.snackbar(
          'success',
          'OTP sent successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to send OTP',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      
    } catch (e) {
      debugPrint('Login error: $e');
      Get.snackbar(
        'Error',
        'Something went wrong',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      setLoading(false);
    }
  }
  //------------------------End Added Code ------------------------

  @override
  void onClose() {
    phoneController.removeListener(onPhoneChanged);
    phoneController.dispose();
    super.onClose();
  }
}

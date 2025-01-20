import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purify/core/routes/route_helper.dart';
import '../services/auth_service.dart';
import '../repositories/auth_repository.dart';
import '../models/user_model.dart';
import '../models/auth_response_model.dart';

class AuthController extends GetxController {
  final AuthService _authService;
  final AuthRepository _authRepo;

  AuthController({
    required AuthService authService,
    required AuthRepository authRepo,
  })  : _authService = authService,
        _authRepo = authRepo;

  final _isLoading = false.obs;
  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);

  bool get isLoading => _isLoading.value;
  bool get isLoggedIn => _authService.token != null;

  //------------------------ Added Mock Implementation ------------------------
  static const _mockOtpResponse = {
    "timestamp": "1735137078.381110100",
    "status": 200,
    "message": "OTP sent successfully",
    "data": "OTP sent successfully",
    "success": true
  };

  Future<bool> sendOtp(String phoneNumber) async {
    _isLoading.value = true;
    try {
      /* Original Implementation
      final response = await _authRepo.sendOtp(phoneNumber);
      if (response.statusCode == 200 && response.body != null) {
        final otpResponse = SendOtpResponse.fromJson(response.body as Map<String, dynamic>);
        return otpResponse.success;
      }
      return false;
      */

      // Mock Implementation
      await Future.delayed(const Duration(seconds: 1)); // Simulate API delay
      final otpResponse = SendOtpResponse.fromJson(_mockOtpResponse);
      return otpResponse.success;
      
    } catch (e) {
      debugPrint('Login error: $e');
      return false;
    } finally {
      _isLoading.value = false;
    }
  }
  //------------------------End Added Code ------------------------

  Future<void> logout() async {
    await _authService.logout();
    currentUser.value = null;
    Get.offAllNamed(RouteHelper.getLoginRoute());
  }
} 
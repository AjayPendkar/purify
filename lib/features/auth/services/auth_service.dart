import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:purify/core/routes/route_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../repositories/auth_repository.dart';
import 'package:get_storage/get_storage.dart';

class AuthService extends GetxService {
  final AuthRepository authRepository;
  final SharedPreferences prefs;
  final GetStorage _storage = GetStorage();
  static const String TOKEN_KEY = 'auth_token';
  static const String USER_KEY = 'user_data';
  
  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  final Rx<String?> _token = Rx<String?>(null);
  
  String? get token => _token.value;
  
  AuthService({
    required this.authRepository,
    required this.prefs,
  });

  @override
  void onInit() {
    super.onInit();
    _loadSavedAuth();
  }

  void _loadSavedAuth() {
    _token.value = _storage.read(TOKEN_KEY);
    if (_token.value != null) {
      authRepository.setToken(_token.value!);
    }
    final userData = _storage.read(USER_KEY);
    if (userData != null) {
      try {
        currentUser.value = UserModel.fromJson(userData);
      } catch (e) {
        debugPrint('Error loading saved user data: $e');
      }
    }
  }

  Future<bool> checkAuth() async {
    try {
      debugPrint('Checking auth...');
      final storedToken = _storage.read<String>(TOKEN_KEY);
      debugPrint('Stored token: ${storedToken != null}');
      debugPrint('Token value: $storedToken');
      
      if (storedToken == null || storedToken.isEmpty) {
        return false;
      }

      _token.value = storedToken;
      authRepository.setToken(storedToken);
      
      final response = await authRepository.getUserProfile();
      
      if (response.statusCode == 200 && response.body != null) {
        final userData = response.body['data'] as Map<String, dynamic>;
        final user = UserModel.fromJson(userData);
        await _storage.write(USER_KEY, user.toJson());
        currentUser.value = user;
        return true;
      }

      await logout();
      return false;
    } catch (e) {
      debugPrint('Auth check error: $e');
      await logout();
      return false;
    }
  }

  Future<void> handleTokenExpiration() async {
    final savedPhone = getSavedPhone();
    if (savedPhone != null) {
      // If phone exists, go to login
      await logout();
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      // If no phone, go to welcome screen
      await logout();
      Get.offAllNamed(RouteHelper.getWellcomeToPurifyRoute());
    }
  }

  Future<void> saveUserAndToken(UserModel user) async {
    try {
      debugPrint('Saving token: ${user.token}');
      
      if (user.token != null) {
        // Save token
        await _storage.write(TOKEN_KEY, user.token);
        _token.value = user.token;
        
        // Save phone number
        if (user.phone != null) {
          await _storage.write('phone', user.phone);
        }
        
        // Update API client token
        authRepository.setToken(user.token!);
        
        // Save full user data
        final userData = user.toJson();
        await _storage.write(USER_KEY, userData);
        currentUser.value = user;
        
        // Verify saved data
        final savedToken = _storage.read<String>(TOKEN_KEY);
        debugPrint('Verified saved token: $savedToken');
      } else {
        debugPrint('Warning: Attempted to save null token');
      }
    } catch (e) {
      debugPrint('Error saving auth data: $e');
    }
  }

  // Save phone number when user enters it
  Future<void> savePhone(String phone) async {
    await _storage.write('phone', phone);
  }

  String? getSavedPhone() {
    return _storage.read<String>('phone');
  }

  Future<void> logout() async {
    await _storage.remove(TOKEN_KEY);
    await _storage.remove(USER_KEY);
    await _storage.remove('phone');
    _token.value = null;
    currentUser.value = null;
  }
} 
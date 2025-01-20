import 'package:get/get.dart';
import '../../../core/api/api_client.dart';
import '../models/auth_response_model.dart';
import '../models/user_registration_request.dart';
import '../services/auth_service.dart';

class AuthRepository {
  final ApiClient apiClient;
  
  AuthRepository({required this.apiClient});

  Future<Response<SendOtpResponse>> sendOtp(String phone) async {
    final response = await apiClient.postData(
      '/api/auth/send-otp',
      {'phone': phone},
    );

    if (response.body != null) {
      return Response<SendOtpResponse>(
        statusCode: response.statusCode,
        statusText: response.statusText,
        body: SendOtpResponse.fromJson(response.body),
      );
    }
    
    return Response<SendOtpResponse>(
      statusCode: response.statusCode,
      statusText: response.statusText,
    );
  }

  Future<Response<AuthResponseModel>> verifyOtp(String phone, String otp) async {
    final response = await apiClient.postData(
      '/api/auth/verify-otp',
      {
        'phone': phone,
        'otp': otp,
      },
    );

    if (response.body != null) {
      return Response<AuthResponseModel>(
        statusCode: response.statusCode,
        statusText: response.statusText,
        body: AuthResponseModel.fromJson(response.body),
      );
    }
    
    return Response<AuthResponseModel>(
      statusCode: response.statusCode,
      statusText: response.statusText,
    );
  }

  Future<Response> createUser(String phone) async {
    return await apiClient.postData(
      '/api/users',
      {
        'phone': phone,
        'role': 'USER',
      },
    );
  }

  Future<Response> getUserProfile() async {
    final phone = Get.find<AuthService>().getSavedPhone();
    if (phone == null) {
      return Response(statusCode: 404, statusText: 'Phone number not found');
    }
    return await apiClient.getData('/api/users/phone/$phone');
  }

  void setToken(String token) {
    apiClient.setToken(token);
  }

  Future<Response> updateUserProfile(Map<String, dynamic> data) async {
    final phone = Get.find<AuthService>().getSavedPhone();
    if (phone == null) {
      return Response(statusCode: 404, statusText: 'Phone number not found');
    }
    return await apiClient.postData('/api/users', data);
  }
} 
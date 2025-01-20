class BaseResponse {
  final String timestamp;
  final int status;
  final String message;
  final bool success;

  BaseResponse({
    required this.timestamp,
    required this.status,
    required this.message,
    required this.success,
  });
}

class SendOtpResponse extends BaseResponse {
  final String data;

  SendOtpResponse({
    required super.timestamp,
    required super.status,
    required super.message,
    required super.success,
    required this.data,
  });

  factory SendOtpResponse.fromJson(Map<String, dynamic> json) {
    return SendOtpResponse(
      timestamp: json['timestamp'],
      status: json['status'],
      message: json['message'],
      success: json['success'],
      data: json['data'],
    );
  }
}

class AuthResponseModel extends BaseResponse {
  final AuthData data;

  AuthResponseModel({
    required super.timestamp,
    required super.status,
    required super.message,
    required super.success,
    required this.data,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      timestamp: json['timestamp'],
      status: json['status'],
      message: json['message'],
      success: json['success'],
      data: AuthData.fromJson(json['data']),
    );
  }
}

class AuthData {
  final String token;
  final String message;
  final bool newUser;

  AuthData({
    required this.token,
    required this.message,
    required this.newUser,
  });

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      token: json['token'],
      message: json['message'],
      newUser: json['newUser'],
    );
  }
} 
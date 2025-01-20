class OtpResponseModel {
  final String timestamp;
  final int status;
  final String message;
  final dynamic data;
  final bool success;

  OtpResponseModel({
    required this.timestamp,
    required this.status,
    required this.message,
    required this.data,
    required this.success,
  });

  factory OtpResponseModel.fromJson(Map<String, dynamic> json) {
    return OtpResponseModel(
      timestamp: json['timestamp'],
      status: json['status'],
      message: json['message'],
      data: json['data'],
      success: json['success'],
    );
  }
} 
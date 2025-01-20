class UserRegistrationRequest {
  final String email;
  final String fullName;
  final String gender;
  final String phone;
  final String dateOfBirth;
  final String role;
  final String password;
  final List<Map<String, dynamic>> goals;
  final List<Map<String, dynamic>> healthProblemDetails;

  UserRegistrationRequest({
    required this.email,
    required this.fullName,
    required this.gender,
    required this.phone,
    required this.dateOfBirth,
    required this.role,
    required this.password,
    required this.goals,
    required this.healthProblemDetails,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'fullName': fullName,
    'gender': gender,
    'phone': phone,
    'dateOfBirth': dateOfBirth,
    'role': 'USER',
    'password': '1234', // You might want to handle this differently
    'goals': goals,
    'healthProblemDetails': healthProblemDetails,
  };
} 
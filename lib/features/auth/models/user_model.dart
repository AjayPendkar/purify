class UserModel {
  final String? token;
  final String? firstName;
  final String? dob;
  final String? gender;
  final List<String>? problems;
  final String? phone;
  final String? id;
  final String? email;
  final int? age;
  final String? role;
  final List<HealthProblemDetail>? healthProblemDetails;
  final List<dynamic>? goals;
  final String? createdAt;
  final String? updatedAt;
  bool isProfileComplete;

  UserModel({
    this.token,
    this.firstName,
    this.dob,
    this.gender,
    this.problems,
    this.phone,
    this.id,
    this.email,
    this.age,
    this.role,
    this.healthProblemDetails,
    this.goals,
    this.createdAt,
    this.updatedAt,
    this.isProfileComplete = false,
  });

  bool get _isProfileCompleteComputed => 
    firstName != null && 
    dob != null && 
    gender != null && 
    problems != null &&
    problems!.isNotEmpty;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    List<HealthProblemDetail> healthProblems = [];
    if (json['healthProblemDetails'] != null) {
      healthProblems = (json['healthProblemDetails'] as List)
          .map((x) => HealthProblemDetail.fromJson(x))
          .toList();
    }

    // Extract problem names for backward compatibility
    List<String> problems = healthProblems
        .map((detail) => detail.healthProblem.name)
        .toList();

    return UserModel(
      id: json['id'],
      token: json['token'],
      firstName: json['fullName'],
      email: json['email'],
      dob: json['dateOfBirth'],
      gender: json['gender'],
      phone: json['phone'],
      age: json['age'],
      role: json['role'],
      healthProblemDetails: healthProblems,
      problems: problems,
      goals: json['goals'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      isProfileComplete: json['isProfileComplete'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'token': token,
      'firstName': firstName,
      'email': email,
      'dob': dob,
      'gender': gender,
      'phone': phone,
      'age': age,
      'role': role,
      'healthProblemDetails': healthProblemDetails?.map((x) => x.toJson()).toList(),
      'problems': problems,
      'goals': goals,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'isProfileComplete': isProfileComplete,
    };
  }

  UserModel copyWith({
    String? token,
    String? firstName,
    String? dob,
    String? gender,
    List<String>? problems,
    String? phone,
    bool? isProfileComplete,
  }) {
    return UserModel(
      token: token ?? this.token,
      firstName: this.firstName,
      dob: this.dob,
      gender: this.gender,
      problems: this.problems,
      phone: phone ?? this.phone,
      isProfileComplete: isProfileComplete ?? this.isProfileComplete,
    );
  }

  @override
  String toString() {
    return 'UserModel(token: $token, firstName: $firstName, dob: $dob, gender: $gender, phone: $phone, problems: $problems, isProfileComplete: $isProfileComplete)';
  }
}

class HealthProblemDetail {
  final String id;
  final HealthProblem healthProblem;
  final String symptoms;
  final String severity;
  final String sinceWhen;
  final String extraInformation;

  HealthProblemDetail({
    required this.id,
    required this.healthProblem,
    required this.symptoms,
    required this.severity,
    required this.sinceWhen,
    required this.extraInformation,
  });

  factory HealthProblemDetail.fromJson(Map<String, dynamic> json) {
    return HealthProblemDetail(
      id: json['id'],
      healthProblem: HealthProblem.fromJson(json['healthProblem']),
      symptoms: json['symptoms'] ?? '',
      severity: json['severity'],
      sinceWhen: json['sinceWhen'],
      extraInformation: json['extraInformation'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'healthProblem': healthProblem.toJson(),
      'symptoms': symptoms,
      'severity': severity,
      'sinceWhen': sinceWhen,
      'extraInformation': extraInformation,
    };
  }
}

class HealthProblem {
  final String id;
  final String name;
  final String description;

  HealthProblem({
    required this.id,
    required this.name,
    required this.description,
  });

  factory HealthProblem.fromJson(Map<String, dynamic> json) {
    return HealthProblem(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
} 
class UserInfo {
  final String? name;
  final String? gender;

  UserInfo({this.name, this.gender});

  UserInfo copyWith({String? name, String? gender}) {
    return UserInfo(
      name: name ?? this.name,
      gender: gender ?? this.gender,
    );
  }
} 
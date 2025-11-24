class UserModel {
  final String id;
  final String name;
  final String surname;
  final String email;
  final String? birthday;
  final String? phoneNumber;
  final String? profileImagePath;

  UserModel({
    required this.id,
    required this.name,
    required this.surname,
    required this.email,
    this.birthday,
    this.phoneNumber,
    this.profileImagePath,
  });

  String get fullName => '$name $surname';

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      surname: json['surname'] ?? '',
      email: json['email'] ?? '',
      birthday: json['birthday'],
      phoneNumber: json['phoneNumber'],
      profileImagePath: json['profileImagePath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'email': email,
      'birthday': birthday,
      'phoneNumber': phoneNumber,
      'profileImagePath': profileImagePath,
    };
  }
}


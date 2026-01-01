import '../../domain/entities/user_entity.dart';

class LoginResponseModel {
  final int id;
  final String email;
  final String token;

  LoginResponseModel({
    required this.id,
    required this.email,
    required this.token,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      id: json['id'] ?? 0,
      email: json['email'] ?? '', // JSONPlaceholder provides 'email'
      token: 'dummy_token', // Provide a dummy token since JSONPlaceholder doesn't return one
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      token: token,
    );
  }
}

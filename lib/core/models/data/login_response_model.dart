import 'package:ntigradproject/features/auth/data/model/user_model.dart';

class LoginResponseModel {
  final String? accessToken;
  final String? refreshToken;
  final UserModel? user;

  LoginResponseModel({
    this.accessToken,
    this.refreshToken,
    this.user,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }
}

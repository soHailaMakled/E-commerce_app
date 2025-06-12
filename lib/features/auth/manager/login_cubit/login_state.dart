import 'package:ntigradproject/features/auth/data/model/user_model.dart';

abstract class LoginState {}

class LoginInit extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final UserModel user;
  LoginSuccess(this.user);
}

class LoginError extends LoginState {
  final String error;
  LoginError(this.error);
}

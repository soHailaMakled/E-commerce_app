abstract class RegisterState {}

class RegisterInit extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final String msg;
  RegisterSuccess(this.msg);
}

class RegisterError extends RegisterState {
  final String error;
  RegisterError(this.error);
}

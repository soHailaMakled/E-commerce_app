import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ntigradproject/features/auth/data/repo/profile_repo.dart';
import 'package:ntigradproject/features/auth/manager/register_cubit/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  static RegisterCubit get(context) => BlocProvider.of(context);

  RegisterCubit() : super(RegisterInit());

  final ProfileRepo repo = ProfileRepo();

  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  void onRegister() async {
    if (validate()) {
      emit(RegisterLoading());

      final response = await repo.register(
        username: username.text.trim(),
        password: password.text.trim(),
        email: email.text.trim(),
        phone: phone.text.trim(),
      );

      response.fold(
            (error) => emit(RegisterError(error)),
            (successMessage) => emit(RegisterSuccess(successMessage!)),
      );
    }
  }

  bool validate() {
    if (formKey.currentState?.validate() ?? false) {
      if (password.text != confirmPassword.text) {
        emit(RegisterError("كلمتا المرور غير متطابقتين"));
        return false;
      }
      return true;
    }
    return false;
  }

  @override
  Future<void> close() {
    username.dispose();
    password.dispose();
    confirmPassword.dispose();
    email.dispose();
    phone.dispose();
    return super.close();
  }
}

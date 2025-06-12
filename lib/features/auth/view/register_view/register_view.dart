import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ntigradproject/core/resources_manager/appbar_main.dart';
import 'package:ntigradproject/core/utils/app-colors.dart';
import 'package:ntigradproject/core/utils/app_icons.dart';
import 'package:ntigradproject/core/utils/app_strings.dart';
import 'package:ntigradproject/features/auth/manager/register_cubit/register_cubit.dart'; // تأكدي من هذا الاستيراد
import 'package:ntigradproject/features/auth/manager/register_cubit/register_state.dart';
import 'package:ntigradproject/features/auth/view/login_view/login_view.dart';
import 'package:ntigradproject/features/auth/view/widget/form_field_main.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(leadingicon: const Icon(Icons.arrow_back_ios)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: RegisterCubit.get(context).formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                AppStrings.createacc,
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 30),
              MyTextFormField(
                controller: RegisterCubit.get(context).username,
                validator: (text) {
                  if (text == null || text.isEmpty) return 'أدخل اسمك';
                  final RegExp nameRegex = RegExp(r'^[a-zA-Z ]+$');
                  return nameRegex.hasMatch(text)
                      ? null
                      : 'يجب أن يكون الاسم بالأحرف الإنجليزية فقط';
                },
                labeltext: AppStrings.fullname,
                icon: MyAppIcons.user,
                bottommargin: 10.0,
              ),
              MyTextFormField(
                controller: RegisterCubit.get(context).phone,
                validator: (text) {
                  if (text == null || text.isEmpty) return 'أدخل رقم الهاتف';
                  final RegExp phoneRegex =
                  RegExp(r'^(010|011|012|015)[0-9]{8}$');
                  return phoneRegex.hasMatch(text)
                      ? null
                      : 'رقم الهاتف غير صحيح';
                },
                labeltext: AppStrings.phone,
                icon: MyAppIcons.call,
                bottommargin: 10.0,
              ),
              MyTextFormField(
                controller: RegisterCubit.get(context).email,
                validator: (text) {
                  if (text == null || text.isEmpty)
                    return 'أدخل البريد الإلكتروني';
                  final RegExp emailRegex = RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                  return emailRegex.hasMatch(text)
                      ? null
                      : 'البريد الإلكتروني غير صحيح';
                },
                labeltext: AppStrings.email,
                icon: MyAppIcons.email,
                bottommargin: 10.0,
              ),
              MyTextFormField(
                controller: RegisterCubit.get(context).password,
                validator: (text) {
                  if (text == null || text.isEmpty)
                    return 'أدخل كلمة المرور';
                  return text.length >= 6
                      ? null
                      : 'كلمة المرور يجب أن تكون 6 أحرف أو أكثر';
                },
                labeltext: AppStrings.password,
                icon: MyAppIcons.password,
                endicon: const Icon(Icons.remove_red_eye_outlined),
                bottommargin: 10.0,
              ),
              MyTextFormField(
                controller: RegisterCubit.get(context).confirmPassword,
                validator: (text) {
                  if (text == null || text.isEmpty)
                    return 'أدخل تأكيد كلمة المرور';
                  if (text != RegisterCubit.get(context).password.text)
                    return 'كلمة المرور غير متطابقة';
                  return null;
                },
                labeltext: AppStrings.confirmpass,
                icon: MyAppIcons.password,
                endicon: const Icon(Icons.remove_red_eye_outlined),
                bottommargin: 10.0,
              ),
              const SizedBox(height: 20),
              BlocConsumer<RegisterCubit, RegisterState>(
                listener: (context, state) {
                  if (state is RegisterSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("تم التسجيل بنجاح")),
                    );
                    Navigator.pushReplacementNamed(context, '/login');
                  } else if (state is RegisterError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is RegisterLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Container(
                    width: double.infinity,
                    height: 55,
                    margin: const EdgeInsets.symmetric(horizontal: 29),
                    decoration: BoxDecoration(
                      color: MyAppColors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: TextButton(
                      onPressed: () {
                        if (RegisterCubit.get(context)
                            .formKey
                            .currentState!
                            .validate()) {
                          RegisterCubit.get(context).onRegister();
                        }
                      },
                      child: const Text(
                        AppStrings.register,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: MyAppColors.background,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(AppStrings.haveacc),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: const Text(
                      AppStrings.login,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

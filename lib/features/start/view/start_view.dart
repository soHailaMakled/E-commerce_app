import 'package:flutter/material.dart';
import 'package:ntigradproject/core/resources_manager/button_main.dart';
import 'package:ntigradproject/core/utils/app-colors.dart';
import 'package:ntigradproject/core/utils/app_images.dart';
import 'package:ntigradproject/core/utils/app_strings.dart';
import 'package:ntigradproject/features/auth/view/login_view/login_view.dart';
import 'package:ntigradproject/features/auth/view/register_view/register_view.dart';

class GetStartView extends StatelessWidget {
  const GetStartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          // الخلفية مع الصورة
          Image.asset(
            MyAppImage.getstart,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          // تدرج لونه أسود من الأسفل لتظليل الخلفية
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.43,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withAlpha(160),
                  Colors.black.withAlpha(0),
                ],
              ),
            ),
          ),
          // الأزرار والنصوص
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Text(
                  AppStrings.getstart1,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 34,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
              ),
              Text(
                AppStrings.getstart2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              // زر تسجيل الدخول يوجه إلى LoginView
              MyButton(
                newscreen: const LoginView(),
                top: 24,
                buttontext: AppStrings.login,
                buttoncolor: MyAppColors.red,
                textcolor: MyAppColors.background,
              ),
              // زر التسجيل يوجه إلى RegisterView
              MyButton(
                newscreen: const RegisterView(),
                top: 0,
                buttontext: AppStrings.register,
                buttoncolor: MyAppColors.background,
                textcolor: MyAppColors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

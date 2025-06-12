import 'package:flutter/material.dart';
import 'package:ntigradproject/core/resources_manager/button_main.dart'; // تأكدي من هذا المسار
import 'package:ntigradproject/core/utils/app-colors.dart';
import 'package:ntigradproject/core/utils/app_images.dart'; // تأكدي من هذا المسار
import 'package:ntigradproject/core/utils/app_strings.dart'; // تأكدي من هذا المسار
import 'package:ntigradproject/features/auth/view/login_view/login_view.dart'; // تأكدي من هذا المسار
import 'package:ntigradproject/features/auth/view/register_view/register_view.dart'; // تأكدي من هذا المسار

class GetStartView extends StatelessWidget {
  const GetStartView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          // الخلفية مع الصورة
          Image.asset(
            MyAppImage.getstart, // تأكدي من وجود الصورة في assets
            fit: BoxFit.cover,
            height: screenHeight,
            width: screenWidth,
          ),
          // تدرج لونه أسود من الأسفل لتظليل الخلفية
          Container(
            width: double.infinity,
            height: screenHeight * 0.43, // ارتفاع متجاوب
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.6), // استخدام opacity بدل Alpha
                  Colors.black.withOpacity(0),
                ],
              ),
            ),
          ),
          // الأزرار والنصوص
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: screenWidth * 0.75, // عرض متجاوب
                child: Text(
                  AppStrings.getstart1, // تأكدي من وجود النص في AppStrings
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * 0.085, // ✅ حجم خط متجاوب (مثلاً 8.5% من عرض الشاشة)
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.01), // مسافة بسيطة بين النصين
              Text(
                AppStrings.getstart2, // تأكدي من وجود النص في AppStrings
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenWidth * 0.035, // ✅ حجم خط متجاوب (مثلاً 3.5% من عرض الشاشة)
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              // زر تسجيل الدخول يوجه إلى LoginView
              MyButton(
                newscreen: const LoginView(),
                top: screenHeight * 0.03, // ✅ مسافة علوية متجاوبة (3% من ارتفاع الشاشة)
                buttontext: AppStrings.login,
                buttoncolor: MyAppColors.red, // تأكدي من وجود اللون في MyAppColors
                textcolor: MyAppColors.background, // تأكدي من وجود اللون في MyAppColors
              ),
              // زر التسجيل يوجه إلى RegisterView
              MyButton(
                newscreen: const RegisterView(),
                top: screenHeight * 0.02, // ✅ مسافة علوية متجاوبة (2% من ارتفاع الشاشة)
                buttontext: AppStrings.register,
                buttoncolor: MyAppColors.background,
                textcolor: MyAppColors.red,
              ),
              SizedBox(height: screenHeight * 0.05), // مسافة سفلية متجاوبة
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ntigradproject/core/utils/app-colors.dart';
import 'package:ntigradproject/core/utils/app_icons.dart';
import 'package:ntigradproject/features/start/view/onboarding_view.dart'; // ✅ تم تصحيح المسار لـ onboarding_page.dart

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  void navigateToOnBoardingPage(BuildContext context) { // ✅ تم تغيير اسم الدالة للتوضيح
    Future.delayed(const Duration(seconds: 3), () {
      // ✅ التأكد من أن الـ Widget لا يزال موجوداً في الـ tree قبل استخدام الـ context
      if (!context.mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnBoardingPage()), // ✅ استخدام const مع OnBoardingPage
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // هذه الدالة (addPostFrameCallback) تُنفذ بعد بناء الـ frame الأول للـ Widget
    WidgetsBinding.instance.addPostFrameCallback((_) {
      navigateToOnBoardingPage(context); // ✅ استدعاء الدالة المحدثة
    });
    return Scaffold(
      backgroundColor: MyAppColors.background, // تأكدي من وجود هذا اللون في MyAppColors
      body: Center(child: SvgPicture.asset(MyAppIcons.splash)), // تأكدي من وجود الأيقونة
    );
  }
}

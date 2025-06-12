import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ntigradproject/core/utils/app-colors.dart';
import 'package:ntigradproject/core/utils/app_icons.dart';
import 'package:ntigradproject/features/start/view/onboarding_view.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  void navigateToStartPage(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => OnBoardingPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      navigateToStartPage(context);
    });
    return Scaffold(
      backgroundColor: MyAppColors.background,
      body: Center(child: SvgPicture.asset(MyAppIcons.splash)),
    );
  }
}
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:ntigradproject/core/utils/app_icons.dart'; // تأكد من هذا المسار
import 'package:ntigradproject/features/start/view/start_view.dart'; // تأكد من هذا المسار

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    // الانتقال إلى GetStartView بعد الانتهاء من الـ Onboarding
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const GetStartView()),
    );
  }

  // دالة مساعدة لبناء الصور مع ضبط حجم متجاوب
  Widget _buildImage(String assetName, BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // ضبط عرض الصورة ليكون نسبة من عرض الشاشة (مثلاً 80% من عرض الشاشة)
    return SvgPicture.asset(assetName, width: screenWidth * 0.8);
  }

  @override
  Widget build(BuildContext context) {
    // ضبط حجم الخط الأساسي ليتناسب مع عرض الشاشة
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height; // ✅ تم تعريف screenHeight هنا
    final bodyStyle = TextStyle(fontSize: screenWidth * 0.045); // حجم خط متجاوب
    final titleStyle = TextStyle(fontSize: screenWidth * 0.07, fontWeight: FontWeight.w700); // حجم خط متجاوب

    var pageDecoration = PageDecoration(
      titleTextStyle: titleStyle,
      bodyTextStyle: bodyStyle,
      // padding متجاوب
      bodyPadding: EdgeInsets.fromLTRB(screenWidth * 0.04, 0.0, screenWidth * 0.04, screenHeight * 0.02),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.125, // padding رأسي ثابت نسبياً
      ),
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      autoScrollDuration: 3000,
      infiniteAutoScroll: true,
      globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.02, right: screenWidth * 0.04), // padding متجاوب
            child: TextButton(
              onPressed: () {
                _onIntroEnd(context);
              },
              child: Text(
                'Skip',
                style: TextStyle(
                  fontSize: screenWidth * 0.04, // حجم خط متجاوب
                  color: Theme.of(context).primaryColor, // استخدام لون الـ primaryTheme
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      pages: [
        PageViewModel(
          title: "Choose Products",
          body: "Amet minim mollit non deserunt ullamco est \n sit aliqua dolor do amet sint. Velit officia \n consequat duis enim velit mollit.",
          image: _buildImage(MyAppIcons.start, context), // تمرير الـ context
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Make Payment",
          body: "Amet minim mollit non deserunt ullamco est \n sit aliqua dolor do amet sint. Velit officia \n consequat duis enim velit mollit.",
          image: _buildImage(MyAppIcons.salesconsulting, context), // تمرير الـ context
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Get Your Order",
          body: "Amet minim mollit non deserunt ullamco est \n sit aliqua dolor do amet sint. Velit officia \n consequat duis enim velit mollit.",
          image: _buildImage(MyAppIcons.shoppingbag, context), // تمرير الـ context
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // يمكن جعل Skip يعمل مثل Done أو الانتقال إلى صفحة معينة
      showSkipButton: true, // تأكد من إظهار زر Skip
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,

      back: Text(
        'Prev',
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: screenWidth * 0.04), // حجم خط متجاوب
      ),
      next: Text(
        'Next',
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: screenWidth * 0.04), // حجم خط متجاوب
      ),
      done: Text(
        'Done',
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: screenWidth * 0.04), // حجم خط متجاوب
      ),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: EdgeInsets.all(screenWidth * 0.04), // margin متجاوب
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : EdgeInsets.fromLTRB(screenWidth * 0.02, screenHeight * 0.005, screenWidth * 0.02, screenHeight * 0.005), // padding متجاوب
      dotsDecorator: DotsDecorator(
        size: Size(screenWidth * 0.025, screenWidth * 0.025), // حجم النقط متجاوب
        color: const Color(0xFFBDBDBD),
        activeSize: Size(screenWidth * 0.1, screenWidth * 0.02), // حجم النقطة النشطة متجاوب
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(screenWidth * 0.06)), // حواف دائرية متجاوبة
        ),
      ),
    );
  }
}

// كلاس HomePage لم يتم تعديله في هذه المراجعة
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _onBackToIntro(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const OnBoardingPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("This is the screen after Introduction"),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _onBackToIntro(context),
              child: const Text('Back to Introduction'),
            ),
          ],
        ),
      ),
    );
  }
}

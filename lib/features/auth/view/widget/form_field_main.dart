import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ntigradproject/core/utils/app-colors.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    super.key,
    this.bottommargin = 10.0,  // ✅ تحديد قيمة افتراضية
    required this.labeltext,
    required this.icon,
    this.endicon,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,  // ✅ دعم أنواع الإدخال
  });

  final double bottommargin;
  final String labeltext;
  final String icon;
  final Widget? endicon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      margin: EdgeInsets.only(left: 30, right: 30, bottom: bottommargin),
      padding: EdgeInsets.symmetric(horizontal: 10), // ✅ تحسين الـ padding
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: MyAppColors.textformbordercolor),
        color: MyAppColors.textformcolor,
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,  // ✅ دعم أنواع الإدخال المختلفة
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: labeltext,
          prefixIcon: Padding(  // ✅ استخدام `prefixIcon` بدلاً من `icon`
            padding: EdgeInsets.all(10),
            child: SvgPicture.asset(icon, height: 24, width: 24),
          ),
          suffixIcon: endicon,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SpecialButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed; // ✅ جعل `onPressed` اختياريًا لتجنب الأخطاء
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final bool isLoading; // ✅ لإظهار مؤشر تحميل عند الضغط

  const SpecialButton({
    super.key,
    required this.text,
    this.onPressed, // ✅ لم يعد `required` لمنع الخطأ
    this.backgroundColor = Colors.red,
    this.textColor = Colors.white,
    this.fontSize = 16,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed, // ✅ تعطيل الزر عند التحميل
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: isLoading
          ? SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          color: textColor,
          strokeWidth: 2,
        ),
      )
          : Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

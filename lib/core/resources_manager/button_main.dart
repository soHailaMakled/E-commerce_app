import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.buttontext,
    required this.buttoncolor,
    required this.textcolor,
    required this.top,
    required this.newscreen,
  });

  final String buttontext;
  final Color buttoncolor;
  final Color textcolor;
  final double top;
  final Widget newscreen;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 55, right: 55, bottom: 15, top: top),
      width: 279,
      height: 55,
      decoration: BoxDecoration(
        color: buttoncolor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => newscreen,
            ), // التنقل باستخدام Navigator.push
          );
        },
        child: Center(
          child: Text(
            buttontext,
            style: TextStyle(
              color: textcolor,
              fontSize: 23,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
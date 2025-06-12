import 'package:flutter/material.dart';
import 'package:ntigradproject/core/utils/app-colors.dart';

class OrderActions extends StatelessWidget {
  const OrderActions({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(38),
        color: MyAppColors.red,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: MyAppColors.background,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:ntigradproject/core/utils/app-colors.dart';
import 'package:ntigradproject/core/utils/app_strings.dart';

class LanguageCard extends StatelessWidget {
  const LanguageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.272,
      height: 40,
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.136,
            height: 40,
            decoration: BoxDecoration(
              color: MyAppColors.pink,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
            ),
            child: Center(
              child: Text(
                AppStrings.ar,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: MyAppColors.black,
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.136,
            height: 40,
            decoration: BoxDecoration(
              color: MyAppColors.red,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
            ),
            child: Center(
              child: Text(
                AppStrings.en,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: MyAppColors.background,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ntigradproject/core/utils/app_icons.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, required this.icon, required this.text});
  final String icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 26, right: 26, bottom: 20),
      width: double.infinity,
      height: 26,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(icon),
          SizedBox(width: 10),
          Text(text),
          Spacer(),
          SvgPicture.asset(MyAppIcons.arrowgo),
        ],
      ),
    );
  }
}
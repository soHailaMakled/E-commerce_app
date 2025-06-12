import 'package:flutter/material.dart';
import 'package:ntigradproject/core/utils/app-colors.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key, this.leadingicon, this.appbartitle});

  final Widget? leadingicon;
  final Widget? appbartitle;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: MyAppColors.background,
      leading: leadingicon,
      centerTitle: true,
      title: appbartitle,
    );
  }

  @override
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
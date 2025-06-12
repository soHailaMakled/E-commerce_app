import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ntigradproject/core/resources_manager/appbar_main.dart';
import 'package:ntigradproject/core/utils/app-colors.dart';
import 'package:ntigradproject/core/utils/app_icons.dart';
import 'package:ntigradproject/core/utils/app_strings.dart';
import 'package:ntigradproject/features/order/view/widget/order_status.dart';

class MyorderView extends StatelessWidget {
  const MyorderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        leadingicon: Icon(Icons.arrow_back_ios),
        appbartitle: Text(
          AppStrings.myordertitle,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 30),
              Row(
                children: [
                  OrderStatus(
                    color: MyAppColors.red,
                    text: Text(
                      AppStrings.active,
                      style: TextStyle(
                        color: MyAppColors.background,
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  OrderStatus(
                    color: MyAppColors.pink,
                    text: Text(
                      AppStrings.compl,
                      style: TextStyle(
                        color: MyAppColors.red,
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  OrderStatus(
                    color: MyAppColors.pink,
                    text: Text(
                      AppStrings.cancelled,
                      style: TextStyle(
                        color: MyAppColors.red,
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 80),
              SvgPicture.asset(MyAppIcons.docs, height: 167, width: 140),
              SizedBox(height: 20),
              Text(
                AppStrings.noorder,
                style: TextStyle(
                  color: MyAppColors.red,
                  fontWeight: FontWeight.w500,
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
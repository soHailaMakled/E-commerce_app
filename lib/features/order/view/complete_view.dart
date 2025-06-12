import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ntigradproject/core/resources_manager/appbar_main.dart';
import 'package:ntigradproject/core/utils/app-colors.dart';
import 'package:ntigradproject/core/utils/app_icons.dart';
import 'package:ntigradproject/core/utils/app_images.dart';
import 'package:ntigradproject/core/utils/app_strings.dart';
import 'package:ntigradproject/features/order/view/widget/order_status.dart';

class CompleteView extends StatelessWidget {
  const CompleteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        appbartitle: Text(
          AppStrings.myordertitle,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        leadingicon: Icon(Icons.arrow_back_ios),
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          Row(
            children: [
              OrderStatus(
                color: MyAppColors.pink,
                text: Text(
                  AppStrings.active,
                  style: TextStyle(
                    color: MyAppColors.red,
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
              ),
              OrderStatus(
                color: MyAppColors.red,
                text: Text(
                  AppStrings.compl,
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
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.130,
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),

              color: MyAppColors.background,
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  offset: Offset(0, 3),
                  spreadRadius: 0,
                  color: MyAppColors.shadow,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  width: MediaQuery.of(context).size.width * 0.275,
                  height: MediaQuery.of(context).size.height * 0.130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage(MyAppImage.shirt),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          AppStrings.mensstarry,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 100),
                        Text(
                          AppStrings.itemprice,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          AppStrings.orderdate,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                          ),
                        ),
                        SizedBox(width: 90),
                        Text(
                          AppStrings.itemcount,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        SvgPicture.asset(
                          MyAppIcons.correct,
                          width: 15,
                          height: 15,
                          color: MyAppColors.red,
                        ),
                        SizedBox(width: 5),
                        Text(
                          AppStrings.orderdelivered,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: MyAppColors.red,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
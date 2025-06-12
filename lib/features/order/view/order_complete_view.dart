import 'package:flutter/material.dart';
import 'package:ntigradproject/core/resources_manager/appbar_main.dart';
import 'package:ntigradproject/core/utils/app-colors.dart';
import 'package:ntigradproject/core/utils/app_images.dart';
import 'package:ntigradproject/core/utils/app_strings.dart';
import 'package:ntigradproject/features/cart/views/widget/second_order_card.dart';

class OrderCompleteView extends StatelessWidget {
  const OrderCompleteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        leadingicon: Icon(Icons.arrow_back_ios),
        appbartitle: Text(
          AppStrings.orderdetails,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 14.0, right: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  AppStrings.ordernum,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                SizedBox(width: 130),
                Text(
                  AppStrings.compl,
                  style: TextStyle(
                    color: MyAppColors.red,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Text(
              AppStrings.orderdate2,
              style: TextStyle(
                color: MyAppColors.datecolor,
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
            OrderCard2(
              image: MyAppImage.ladyorder,
              ordername: AppStrings.product1name,
              orderrate: AppStrings.product1rate,
              orderprice: AppStrings.finalprice1,
              orderoldprice: AppStrings.oldprice1,
            ),
            OrderCard2(
              image: MyAppImage.manorder,
              ordername: AppStrings.product2name,
              orderrate: AppStrings.product2rate,
              orderprice: AppStrings.finalprice2,
              orderoldprice: AppStrings.oldprice2,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(AppStrings.subtotal),
                Spacer(),
                Text(
                  AppStrings.subprice,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(AppStrings.taxfees),
                Spacer(),
                Text(
                  AppStrings.taxprice,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(AppStrings.delivery),
                Spacer(),
                Text(
                  AppStrings.deliveryprice,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Text(
              style: TextStyle(color: MyAppColors.gray),
              "_______________________________________________________",
            ),
            SizedBox(height: 15),

            Row(
              children: [
                Text(
                  AppStrings.totalorders,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
                Spacer(),
                Text(
                  AppStrings.totalordersprice,
                  style: TextStyle(
                    color: MyAppColors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
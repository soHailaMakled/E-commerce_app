import 'package:flutter/material.dart';
import 'package:ntigradproject/core/utils/app-colors.dart';
import 'package:ntigradproject/core/utils/app_strings.dart';

class OrderCard2 extends StatelessWidget {
  const OrderCard2({
    super.key,
    required this.image,
    required this.ordername,
    required this.orderrate,
    required this.orderprice,
    required this.orderoldprice,
  });
  final String image;
  final String ordername;
  final String orderrate;
  final String orderprice;
  final String orderoldprice;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 17, top: 10, right: 17),
      padding: EdgeInsets.all(10),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.23,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: MyAppColors.background,
        boxShadow: [
          BoxShadow(
            blurRadius: 14,
            spreadRadius: -8,
            offset: Offset(0, 6),
            color: MyAppColors.shadow,
          ),
          BoxShadow(
            blurRadius: 9,
            spreadRadius: -7,
            offset: Offset(0, -4),
            color: MyAppColors.shadow,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.345,
                height: MediaQuery.of(context).size.height * 0.154,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(image)),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ordername,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Text(orderrate),
                      Icon(Icons.star, color: MyAppColors.yellow),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(AppStrings.item),
                  Row(
                    children: [
                      Text(
                        orderprice,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 40),
                      Text(
                        orderoldprice,
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: MyAppColors.pricegray,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          Text(
            style: TextStyle(color: MyAppColors.gray),
            "_______________________________________________",
          ),

          Row(
            children: [
              Text(
                AppStrings.totalorder,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
              ),
              SizedBox(width: 160),
              Text(
                orderprice,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
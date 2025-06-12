import 'package:flutter/material.dart';
import 'package:ntigradproject/core/resources_manager/appbar_main.dart';
import 'package:ntigradproject/core/utils/app_strings.dart';
import 'package:ntigradproject/features/cart/views/cart_view.dart';
import 'package:ntigradproject/features/cart/views/widget/second_order_card.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({super.key});

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
      body: SingleChildScrollView(  // ✅ إصلاح مشكلة التمرير
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CartView(),  // ✅ عنصر يعرض حالة الطلب
              SizedBox(height: 10),
              OrderCard2(image: '', ordername: '', orderrate: '', orderprice: '', orderoldprice: '',),  // ✅ كارت يعرض تفاصيل الطلب
              SizedBox(height: 10),
              _buildTotalSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTotalSection() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildPriceRow("Subtotal", 79.00),
          _buildPriceRow("Tax and Fees", 3.00),
          _buildPriceRow("Delivery Fee", 2.00),
          Divider(),
          _buildPriceRow("Order Total", 84.00, isTotal: true),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String title, double amount, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16)),
          Text("LE $amount",
              style: TextStyle(
                fontSize: 18,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                color: isTotal ? Colors.red : Colors.black,
              )),
        ],
      ),
    );
  }
}

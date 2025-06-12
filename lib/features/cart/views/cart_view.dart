import 'package:flutter/material.dart';
import 'package:ntigradproject/features/cart/views/widget/cart_item.dart';
import 'package:ntigradproject/features/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:ntigradproject/core/resources_manager/appbar_main.dart';
import 'package:ntigradproject/core/resources_manager/button_imp.dart';
import 'package:ntigradproject/core/utils/app-colors.dart';
import 'package:ntigradproject/core/utils/app_strings.dart';
import 'package:ntigradproject/features/cart/views/widget/order_card.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: MyAppBar(
        appbartitle: Text(AppStrings.cart),
      ),
      body: cartProvider.cartItems.isEmpty
          ? Center(child: Text("السلة فارغة!", style: TextStyle(fontSize: 18)))
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Text(
              AppStrings.shoppinglist,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.cartItems.length,
              itemBuilder: (context, index) {
                final CartItem item = cartProvider.cartItems[index]; // ✅ استخدام `CartItem` بدلًا من `Map`

                return OrderCard(
                  image: item.image, // ✅ الوصول للبيانات بشكل صحيح
                  ordername: item.name,
                  orderrate: item.name.toString(),
                  orderprice: item.price.toString(),
                  orderoldprice: item.oldPrice.toString(),
                  onRemove: () {
                    cartProvider.removeFromCart(item.id); // ✅ تمرير `id` فقط للحذف
                  },
                );
              },
            ),
          ),
          Divider(color: MyAppColors.gray),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildPriceRow("الإجمالي:", "${cartProvider.totalPrice} جنيه", isTotal: true),
                SizedBox(height: 20),
                SpecialButton(
                  text: "إتمام الطلب",
                  onPressed: () {
                    print("تم الانتقال لصفحة الدفع");
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
    return Row(
      children: [
        Text(label, style: TextStyle(fontSize: isTotal ? 18 : 16, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
        Spacer(),
        Text(value, style: TextStyle(fontSize: isTotal ? 18 : 16, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal, color: isTotal ? Colors.red : Colors.black)),
      ],
    );
  }
}

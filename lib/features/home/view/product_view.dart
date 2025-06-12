import 'package:flutter/material.dart';
import 'package:ntigradproject/core/resources_manager/button_imp.dart';
import 'package:ntigradproject/features/cart/views/widget/cart_item.dart';
import 'package:ntigradproject/features/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class ProductView extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(product["name"])),
      body: Column(
        children: [
          Image.asset(product["image"], height: 200),
          SizedBox(height: 10),
          Text(product["name"], style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          Text("السعر: ${product["price"]} جنيه", style: TextStyle(fontSize: 18, color: Colors.red)),
          SizedBox(height: 20),
          SpecialButton(
            text: "إضافة إلى السلة",
            onPressed: () {
              cartProvider.addToCart(product as CartItem);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("${product["name"]} تمت إضافته إلى السلة")),
              );
            },
          ),
        ],
      ),
    );
  }
}

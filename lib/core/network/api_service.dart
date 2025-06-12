import 'package:flutter/material.dart';
import 'package:ntigradproject/core/network/end_points.dart';
import 'package:ntigradproject/features/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:ntigradproject/core/network/api_helper.dart';
import 'package:ntigradproject/core/network/api_response.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final APIHelper apiService = APIHelper(); // ✅ استخدام `APIHelper`

    return Scaffold(
      appBar: AppBar(title: Text("إتمام الطلب")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("إجمالي المبلغ: ${cartProvider.totalPrice} جنيه",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (cartProvider.cartItems.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("سلة التسوق فارغة!")),
                  );
                  return;
                }

                try {
                  ApiResponse response = await apiService.postRequest( // ✅ استخدام `postRequest()`
                    endPoint: ApiEndpoint.checkout, // ✅ التأكد من `checkout` في `end_points.dart`
                    data: {
                      "items": cartProvider.cartItems.map((item) => item.toJson()).toList(),
                    },
                    isAuthorized: true,
                  );

                  if (response.status) {
                    cartProvider.clearCart();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("تم إتمام الطلب بنجاح: ${response.data["order_id"]} 🚀")),
                    );
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("فشل في إتمام الطلب: ${response.message}")),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("خطأ أثناء إتمام الطلب: $e")),
                  );
                }
              },
              child: Text("إتمام الطلب"),
            ),
          ],
        ),
      ),
    );
  }
}

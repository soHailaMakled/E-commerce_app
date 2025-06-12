import 'package:flutter/material.dart';
import 'package:ntigradproject/core/utils/app-colors.dart';
import 'package:ntigradproject/features/auth/data/model/cart_item_model.dart';
import 'package:ntigradproject/features/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:ntigradproject/core/resources_manager/appbar_main.dart'; // تأكدي من المسار ده
import 'package:ntigradproject/core/resources_manager/button_imp.dart'; // تأكدي من المسار ده
import 'package:ntigradproject/core/utils/app_strings.dart'; // تأكدي من المسار ده
import 'package:ntigradproject/features/cart/views/widget/order_card.dart'; // تأكدي من المسار ده
import 'package:ntigradproject/features/cart/views/checkout_view.dart'; // ✅ استيراد CheckoutView

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: MyAppBar(
        appbartitle: Text(
          AppStrings.cart,
          style: TextStyle(
            fontSize: screenWidth * 0.05, // حجم خط متجاوب
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: cartProvider.cartItems.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart_outlined, size: screenWidth * 0.2), // حجم أيقونة متجاوب
            SizedBox(height: screenHeight * 0.02),
            Text(
              "السلة فارغة! ابدأ التسوق الآن 🛍️",
              style: TextStyle(
                fontSize: screenWidth * 0.045, // حجم خط متجاوب
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.04), // padding متجاوب
            child: Text(
              AppStrings.shoppinglist,
              style: TextStyle(
                fontSize: screenWidth * 0.04, // حجم خط متجاوب
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.cartItems.length,
              itemBuilder: (context, index) {
                final CartItemModel cartItem = cartProvider.cartItems[index] as CartItemModel; // ✅ استخدام CartItemModel

                return OrderCard(
                  // ✅ الوصول للبيانات من CartItemModel.product
                  image: cartItem.product.imageUrl, // تأكدي أن ProductModel لديه imageUrl
                  ordername: cartItem.product.name,
                  orderrate: cartItem.product.name, // ممكن يكون ده Rating أو اسم المنتج
                  orderprice: cartItem.product.price.toStringAsFixed(2), // تنسيق السعر
                  orderoldprice: "N/A", // لو مفيش سعر قديم، ممكن تحطي N/A
                  // ✅ تمرير الكمية للـ OrderCard لو بيعرضها
                  // orderQuantity: cartItem.quantity,
                  onRemove: () {
                    cartProvider.removeFromCart(cartItem.product.id); // ✅ تمرير id المنتج للحذف
                  },
                  // ✅ إضافة أزرار لزيادة/تقليل الكمية
                  onIncrement: () {
                    cartProvider.updateProductQuantity(cartItem.product.id, cartItem.quantity + 1);
                  },
                  onDecrement: () {
                    cartProvider.updateProductQuantity(cartItem.product.id, cartItem.quantity - 1);
                  },
                );
              },
            ),
          ),
          Divider(color: MyAppColors.gray, height: screenHeight * 0.03), // ارتفاع متجاوب للفاصل
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.04), // padding متجاوب
            child: Column(
              children: [
                _buildPriceRow("الإجمالي:", "${cartProvider.totalPrice.toStringAsFixed(2)} جنيه", isTotal: true, screenWidth: screenWidth), // تمرير screenWidth
                SizedBox(height: screenHeight * 0.02), // مسافة متجاوبة
                SpecialButton(
                  text: "إتمام الطلب",
                  onPressed: () {
                    if (cartProvider.cartItems.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("السلة فارغة، لا يمكن إتمام الطلب!")),
                      );
                      return;
                    }
                    // الانتقال لصفحة CheckoutView
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CheckoutView()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // دالة مساعدة لبناء صفوف عرض الأسعار
  Widget _buildPriceRow(String label, String value, {bool isTotal = false, required double screenWidth}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // توزيع العناصر بالتساوي
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? screenWidth * 0.05 : screenWidth * 0.04, // حجم خط متجاوب
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? screenWidth * 0.05 : screenWidth * 0.04, // حجم خط متجاوب
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colors.redAccent : Colors.black, // لون مميز للإجمالي
          ),
        ),
      ],
    );
  }
}

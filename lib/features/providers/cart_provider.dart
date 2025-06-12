import 'package:flutter/material.dart';

import '../cart/views/widget/cart_item.dart';

class CartProvider extends ChangeNotifier {
  List<CartItem> _cartItems = []; // تحويل القائمة لتصبح List<CartItem>
  double _totalPrice = 0.0;

  List<CartItem> get cartItems => _cartItems;
  double get totalPrice => _totalPrice;

  // إضافة منتج إلى السلة
  void addToCart(CartItem product) {
    _cartItems.add(product);
    _totalPrice += product.price;
    notifyListeners();
  }

  // حذف منتج من السلة باستخدام معرف المنتج (id)
  void removeFromCart(String productId) {
    _cartItems.removeWhere((item) => item.id == productId);
    notifyListeners();
  }

  // مسح السلة بالكامل
  void clearCart() {
    _cartItems.clear();
    _totalPrice = 0.0;
    notifyListeners();
  }
}

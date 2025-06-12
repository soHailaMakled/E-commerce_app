import 'package:flutter/material.dart';
import 'package:ntigradproject/features/auth/data/model/product_model.dart';

class CartProvider extends ChangeNotifier {
  // استخدام List<ProductModel> لتمثيل المنتجات في السلة
  // هذا يجعلنا نتعامل مع الموديل الكامل للمنتج بدلاً من CartItem منفصل
  final List<ProductModel> _cartItems = [];
  double _totalPrice = 0.0;

  List<ProductModel> get cartItems => _cartItems;
  double get totalPrice => _totalPrice;

  // دالة لإضافة منتج إلى السلة
  void addToCart(ProductModel product) {
    // يمكن هنا إضافة منطق للتحقق إذا كان المنتج موجوداً بالفعل في السلة
    // إذا كان موجوداً، يمكن زيادة الكمية بدلاً من إضافة منتج جديد
    _cartItems.add(product);
    _totalPrice += product.price; // تأكدي أن product.price موجودة وصحيحة
    notifyListeners(); // إعلام المستمعين بالتغيير
  }

  // دالة لحذف منتج من السلة باستخدام معرف المنتج (id)
  void removeFromCart(String productId) {
    // البحث عن المنتج بالـ ID وحذفه
    _cartItems.removeWhere((item) => item.id == productId);
    // إعادة حساب السعر الإجمالي بعد الحذف (أو طرح سعر المنتج المحذوف)
    _recalculateTotalPrice();
    notifyListeners();
  }

  // دالة لمسح السلة بالكامل
  void clearCart() {
    _cartItems.clear();
    _totalPrice = 0.0;
    notifyListeners();
  }

  // دالة مساعدة لإعادة حساب السعر الإجمالي
  // هذه الدالة مفيدة بعد عمليات الحذف لضمان دقة السعر الإجمالي
  void _recalculateTotalPrice() {
    _totalPrice = 0.0;
    for (var item in _cartItems) {
      _totalPrice += item.price; // تأكدي أن item.price موجودة
    }
  }

// يمكن إضافة دوال أخرى مفيدة:
// - updateProductQuantity(String productId, int quantity)
// - getProductQuantity(String productId)
// - checkProductInCart(String productId)
}

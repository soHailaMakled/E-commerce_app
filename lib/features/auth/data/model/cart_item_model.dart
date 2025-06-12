// lib/features/cart/data/model/cart_item_model.dart
import 'package:ntigradproject/features/auth/data/model/product_model.dart';

// هذا الكلاس يمثل عنصر واحد في السلة (المنتج وكميته)
class CartItemModel {
  final ProductModel product;
  int quantity;

  CartItemModel({
    required this.product,
    this.quantity = 1, // الكمية الافتراضية هي 1
  });

  // زيادة الكمية
  void incrementQuantity() {
    quantity++;
  }

  // تقليل الكمية، مع التأكد من أنها لا تقل عن 1
  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }

  // السعر الإجمالي لهذا العنصر (السعر * الكمية)
  double get totalPrice => product.price * quantity;

  // تحويل CartItemModel إلى Map (لاستخدامه في API Checkout مثلاً)
  Map<String, dynamic> toJson() {
    return {
      'product_id': product.id, // ID المنتج
      'quantity': quantity, // الكمية
      'unit_price': product.price, // سعر الوحدة (اختياري، حسب API)
      'total_item_price': totalPrice, // السعر الإجمالي لهذا العنصر
    };
  }
}

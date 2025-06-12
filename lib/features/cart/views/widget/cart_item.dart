class CartItem {
  final String id;
  final String name;
  final String image;
  final int quantity;
  final double price;
  final double oldPrice; // ✅ خاصية السعر القديم

  CartItem({
    required this.id,
    required this.name,
    required this.image,
    required this.quantity,
    required this.price,
    required this.oldPrice, // ✅ تأكد من تمريرها أثناء الإنشاء
  });

  // تحويل الكائن إلى JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "image": image,
      "quantity": quantity,
      "price": price,
      "oldPrice": oldPrice, // ✅ تضمين السعر القديم
    };
  }

  // إنشاء كائن من JSON
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json["id"] ?? '',
      name: json["name"] ?? '',
      image: json["image"] ?? '',
      quantity: json["quantity"] ?? 1,
      price: (json["price"] ?? 0).toDouble(),
      oldPrice: (json["oldPrice"] ?? 0).toDouble(), // ✅ قراءة السعر القديم
    );
  }
}

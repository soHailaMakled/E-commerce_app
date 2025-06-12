import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ntigradproject/core/network/api_endpoint.dart';
import 'package:ntigradproject/features/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:ntigradproject/core/network/api_helper.dart'; // ✅ تأكد من هذا الاستيراد الصحيح لـ APIHelper
import 'package:ntigradproject/core/network/api_response.dart';
import 'package:flutter/foundation.dart'; // لإضافة kDebugMode للـ debugging
// ❌ تأكد من حذف هذا السطر لو موجود في ملفك: import 'package:ntigradproject/core/network/api_service.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  // متغير للتحكم في حالة التحميل
  bool _isLoading = false;

  // مفتاح للتحكم في حالة الفورم والتحقق من صحة المدخلات
  final _formKey = GlobalKey<FormState>();

  // متغيرات لتخزين بيانات عنوان الشحن
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();

  // متغير لتخزين طريقة الدفع المختارة (مثال مبسط)
  String? _selectedPaymentMethod;

  @override
  void dispose() {
    _addressController.dispose();
    _cityController.dispose();
    _zipCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // الحصول على حجم الشاشة لتصميم متجاوب
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final cartProvider = Provider.of<CartProvider>(context);
    final APIHelper apiService = APIHelper();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "إتمام الطلب",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenHeight * 0.02,
        ),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // نص إجمالي المبلغ بحجم خط متجاوب
              Text(
                "إجمالي المبلغ: ${cartProvider.totalPrice.toStringAsFixed(2)} جنيه",
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.03),

              const Divider(),
              SizedBox(height: screenHeight * 0.02),

              // قسم عنوان الشحن
              Text(
                "عنوان الشحن",
                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: "الشارع ورقم المنزل",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الشارع ورقم المنزل مطلوب.';
                  }
                  return null;
                },
              ),
              SizedBox(height: screenHeight * 0.015),
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(
                  labelText: "المدينة",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'المدينة مطلوبة.';
                  }
                  return null;
                },
              ),
              SizedBox(height: screenHeight * 0.015),
              TextFormField(
                controller: _zipCodeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "الرمز البريدي",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرمز البريدي مطلوب.';
                  }
                  if (value.length < 5) {
                    return 'الرمز البريدي قصير جداً.';
                  }
                  return null;
                },
              ),

              SizedBox(height: screenHeight * 0.03),
              const Divider(),
              SizedBox(height: screenHeight * 0.02),

              // قسم اختيار طريقة الدفع
              Text(
                "طريقة الدفع",
                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              DropdownButtonFormField<String>(
                value: _selectedPaymentMethod,
                hint: const Text("اختر طريقة الدفع"),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: const [
                  DropdownMenuItem(
                    value: "cash_on_delivery",
                    child: Text("الدفع عند الاستلام"),
                  ),
                  DropdownMenuItem(
                    value: "credit_card",
                    child: Text("بطاقة الائتمان (غير مفعلة حالياً)"),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'يرجى اختيار طريقة الدفع.';
                  }
                  return null;
                },
              ),

              SizedBox(height: screenHeight * 0.04),

              // زر إتمام الطلب
              ElevatedButton(
                onPressed: () async {
                  // نمنع الضغط على الزر لو فيه عملية تحميل شغالة أو السلة فارغة
                  if (_isLoading || cartProvider.cartItems.isEmpty) {
                    if (cartProvider.cartItems.isEmpty) {
                      _showSnackBar(context, "سلة التسوق فارغة! 🛒");
                    }
                    return;
                  }

                  // التحقق من صحة الفورم قبل إرسال الطلب
                  if (_formKey.currentState?.validate() == false) {
                    _showSnackBar(context, "⚠️ يرجى تصحيح الأخطاء في المدخلات.");
                    return;
                  }

                  // نظهر مؤشر التحميل
                  setState(() {
                    _isLoading = true;
                  });

                  try {
                    ApiResponse response = await apiService.post(
                      ApiEndpoint.checkout,
                      data: {
                        // ✅ تم تغيير item?.toJson() إلى item.toJson()
                        "items": cartProvider.cartItems.map((item) => item.toJson()).toList(),
                        "shipping_address": {
                          "address": _addressController.text,
                          "city": _cityController.text,
                          "zip_code": _zipCodeController.text,
                        },
                        "payment_method": _selectedPaymentMethod,
                        // "user_id": LocalData.userId,
                      },
                      isFormData: false,
                    );

                    if (response.status) {
                      cartProvider.clearCart();
                      _showSnackBar(context, "✅ تم إتمام الطلب بنجاح: ${response.message}");
                      Navigator.pop(context);
                    } else {
                      _showSnackBar(context, "❌ فشل في إتمام الطلب: ${response.message}");
                    }
                  } on DioException catch (e) {
                    if (kDebugMode) {
                      debugPrint('Dio error during checkout: $e');
                    }
                    _showSnackBar(context, "⚠️ خطأ في الاتصال: ${ApiResponse.fromError(e).message}");
                  } catch (e) {
                    if (kDebugMode) {
                      debugPrint('Unexpected error during checkout: $e');
                    }
                    _showSnackBar(context, "🚫 حدث خطأ غير متوقع: يرجى المحاولة لاحقاً.");
                  } finally {
                    setState(() {
                      _isLoading = false;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  textStyle: TextStyle(fontSize: screenWidth * 0.045),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 5,
                ),
                child: const Text("إتمام الطلب"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ميثود مساعدة لعرض الـ SnackBar بشكل موحد
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
      ),
    );
  }
}

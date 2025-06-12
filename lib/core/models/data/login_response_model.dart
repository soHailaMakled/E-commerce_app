import 'package:ntigradproject/features/auth/data/model/user_model.dart';
import 'package:flutter/foundation.dart'; // لإضافة debugPrint في وضع الـ Debug

class LoginResponseModel {
  // الحقول التي تمثل بيانات الاستجابة من الـ API
  // جعل الحقول 'required' يعني أنها يجب أن تكون موجودة وغير فارغة من الـ API
  // إذا كان الـ API قد يعيد هذه الحقول كـ null، يجب تغييرها إلى (final String? accessToken;)
  final String accessToken;
  final String refreshToken;
  final UserModel user; // الكائن الذي يمثل بيانات المستخدم

  // Constructor الخاص بالكلاس
  LoginResponseModel({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  // Factory constructor لتحويل البيانات من Map (JSON) إلى كائن LoginResponseModel
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    // نستخدم '?? '' لضمان قيمة افتراضية للـ Strings إذا كانت null من الـ API
    // هذا مهم لتجنب الأخطاء إذا كانت الحقول غير قابلة للـ null
    String receivedAccessToken = json['access_token'] ?? '';
    String receivedRefreshToken = json['refresh_token'] ?? '';

    // التحقق من وجود بيانات المستخدم قبل محاولة تحليلها
    // إذا كان 'user' null من الـ API، سنرمي Exception أو نرجع null إذا كان الحقل nullable
    UserModel? receivedUser;
    if (json['user'] != null) {
      try {
        receivedUser = UserModel.fromJson(json['user']);
      } catch (e) {
        if (kDebugMode) {
          debugPrint('Error parsing UserModel from JSON: $e');
        }
        // يمكن التعامل مع هذا الخطأ بشكل مختلف، مثلاً إرجاع null إذا كان 'user' قابلاً للـ null في الكلاس
        throw Exception("Failed to parse user data from login response: $e");
      }
    } else {
      // إذا كان 'user' لازم يكون موجود ووصل null، نرمي Exception
      throw Exception("User data is missing from login response.");
    }

    return LoginResponseModel(
      accessToken: receivedAccessToken,
      refreshToken: receivedRefreshToken,
      user: receivedUser, // بما أن الحقل required، نستخدم ! لتأكيد أنه ليس null بعد التحقق
    );
  }

  // ميثود لتحويل كائن LoginResponseModel إلى Map (JSON) لإعادة إرساله أو حفظه
  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'user': user.toJson(), // نفترض أن UserModel أيضاً لديه ميثود toJson()
    };
  }

  // ميثود copyWith لتعديل قيم محددة وإنشاء نسخة جديدة من الكائن
  // مفيدة جداً في إدارة الحالة (State Management)
  LoginResponseModel copyWith({
    String? accessToken,
    String? refreshToken,
    UserModel? user,
  }) {
    return LoginResponseModel(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      user: user ?? this.user,
    );
  }

  // ميثود toString() لتوفير تمثيل نصي للكائن، مفيدة للتصحيح (Debugging)
  @override
  String toString() {
    return 'LoginResponseModel(\n'
        '  accessToken: $accessToken,\n'
        '  refreshToken: $refreshToken,\n'
        '  user: ${user.toString().replaceAll('\n', '\n  ')}\n' // تنسيق طباعة الـ user object
        ')';
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ntigradproject/features/home/view/home_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// استيراد الشاشات الأساسية
import 'package:ntigradproject/features/start/view/start_view.dart';
import 'package:ntigradproject/features/auth/view/login_view/login_view.dart';
import 'package:ntigradproject/features/auth/view/register_view/register_view.dart';
import 'package:ntigradproject/features/cart/views/cart_view.dart';
import 'package:ntigradproject/features/cart/views/checkout_view.dart';
import 'package:ntigradproject/features/home/view/final_homeview.dart';
import 'package:ntigradproject/features/home/view/product_view.dart';

// استيراد الـ Providers و الـ Cubits
import 'package:ntigradproject/features/providers/cart_provider.dart';
import 'package:ntigradproject/features/auth/manager/register_cubit/register_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // يمكن استخدام SharedPreferences لاحقًا في StartView للتحقق من حالة تسجيل الدخول
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // MultiProvider يغلف MaterialApp لجميع الشاشات
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        BlocProvider(create: (_) => RegisterCubit()),
      ],
      child: MaterialApp(
        title: 'E-Commerce App',
        debugShowCheckedModeBanner: false,
        // نبدأ بشاشة StartView التي تتولى التوجيه
        home: const GetStartView(),
        routes: {
          '/register': (context) => const RegisterView(),
          '/login': (context) => const LoginView(),
          '/main': (context) => const HomeView(),
          '/cart': (context) => const CartView(),
          '/checkout': (context) => const CheckoutView(),
          '/finalhome': (context) => const FinalHomeView(),
          '/product': (context) {
            final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
            return ProductView(product: args);
          },
          '/home': (context) => const HomeView(),
        },
      ),
    );
  }
}

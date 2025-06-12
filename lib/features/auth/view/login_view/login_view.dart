import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ntigradproject/features/home/view/home_view.dart';
import 'package:ntigradproject/core/network/api_helper.dart';
import 'package:ntigradproject/core/network/api_response.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // استخدام حقل اسم المستخدم بدلاً من البريد الإلكتروني
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final APIHelper _apiService = APIHelper();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _login() async {
    // طباعات لتتبع القيم
    print("Username before trim: '${_usernameController.text}'");
    print("Password before trim: '${_passwordController.text}'");

    // تحقق محلي: إذا كانت الحقول فارغة
    if (_usernameController.text.trim().isEmpty || _passwordController.text.trim().isEmpty) {
      setState(() {
        _errorMessage = "Username and password are required";
      });
      print("Error: Fields are empty");
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      ApiResponse response = await _apiService.login(
        username: _usernameController.text.trim(),
        password: _passwordController.text.trim(),
      );

      print("API response: ${response.data}");

      if (response.status) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        // استخدام pushAndRemoveUntil لإزالة كل الصفحات السابقة من الstack
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeView()),
              (Route<dynamic> route) => false,
        );
      } else {
        setState(() {
          _errorMessage = response.message;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تسجيل الدخول"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              children: [
                const Text(
                  "مرحبًا بك!",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                // حقل اسم المستخدم
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: "اسم المستخدم",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                // حقل كلمة المرور
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: "كلمة المرور",
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 16),
                _isLoading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _login,
                    child: const Text("تسجيل الدخول"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

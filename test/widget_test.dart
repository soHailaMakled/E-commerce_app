import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ntigradproject/core/utils/app_images.dart';
import 'package:ntigradproject/features/auth/view/login_view/login_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String? _username;
  String? _email;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // تحميل بيانات المستخدم من SharedPreferences
  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? 'مستخدم';
      _email = prefs.getString('email') ?? 'example@example.com';
    });
  }

  // تسجيل الخروج
  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الملف الشخصي"),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // صورة الحساب الشخصي
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(MyAppImage.profile),
            ),
            SizedBox(height: 10),
            Text(
              "مرحبا، $_username",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Divider(),

            // تفاصيل الحساب
            ListTile(
              leading: Icon(Icons.email, color: Colors.redAccent),
              title: Text("البريد الإلكتروني"),
              subtitle: Text(_email ?? ''),
            ),
            // يمكنك إضافة المزيد من تفاصيل الحساب هنا

            Divider(),
            SizedBox(height: 20),

            // زر تسجيل الخروج
            ElevatedButton.icon(
              onPressed: () => _logout(context),
              icon: Icon(Icons.exit_to_app, color: Colors.white),
              label: Text("تسجيل الخروج", style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

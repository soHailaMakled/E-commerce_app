import 'package:flutter/material.dart';
import 'package:ntigradproject/features/auth/view/login_view/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ntigradproject/core/utils/app_images.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String username = "تحميل...";
  String email = "تحميل...";
  String phone = "تحميل...";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? "غير متوفر";
      email = prefs.getString('email') ?? "غير متوفر";
      phone = prefs.getString('phone') ?? "غير متوفر";
    });
  }

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // ✅ حذف جميع بيانات المستخدم

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
            // ✅ صورة الحساب الشخصي
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(MyAppImage.profile),
            ),
            SizedBox(height: 10),
            Text(
              "مرحبًا، $username", // ✅ الآن الاسم ديناميكي
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Divider(),

            // ✅ تفاصيل الحساب
            ListTile(
              leading: Icon(Icons.email, color: Colors.redAccent),
              title: Text("البريد الإلكتروني"),
              subtitle: Text(email),
            ),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.redAccent),
              title: Text("رقم الهاتف"),
              subtitle: Text(phone),
            ),

            Divider(),
            SizedBox(height: 20),

            // ✅ زر تسجيل الخروج
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

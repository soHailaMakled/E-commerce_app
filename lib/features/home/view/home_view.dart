import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الصفحة الرئيسية"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "مرحبًا بك في تطبيق التجارة الإلكترونية",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/cart');
                },
                child: const Text("عرض السلة"),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/checkout');
                },
                child: const Text("إتمام الطلب"),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/finalhome');
                },
                child: const Text("الشاشة النهائية"),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // تمرير معطيات مثال لعرض منتج
                  Navigator.pushNamed(
                    context,
                    '/product',
                    arguments: {
                      "name": "منتج تجريبي",
                      "image": "assets/images/sample.png", // تأكدي أن الصورة موجودة
                      "price": 150,
                      "quantity": 1,
                    },
                  );
                },
                child: const Text("عرض المنتج"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

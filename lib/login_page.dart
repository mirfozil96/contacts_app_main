import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';

import 'bottombar_page.dart';
import 'registr_page.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kirish')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            TextField(
              controller: _usernameController,
              decoration:
                  const InputDecoration(labelText: 'Foydalanuvchi nomi'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Parol'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                final username = _usernameController.text;
                final password = _passwordController.text;
                var box = Hive.box('myBox');
                // Foydalanuvchi nomini tekshirish
                if (box.get('username') == username) {
                  // Parolni tekshirish
                  if (box.get('password') == password) {
                    // Agar tekshiruv muvaffaqiyatli bo'lsa, isLoggedIn qiymatini true qilish
                    box.put('isLoggedIn', true);
                    // Avtomatik ravishda MyHomePage sahifasiga o'tish
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const MyHomePage()));
                  }
                }
              },
              child: const Text('Kirish'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => RegisterPage()));
              },
              child: const Text('Ro\'yxatdan o\'tish'),
            ),
          ],
        ),
      ),
    );
  }
}

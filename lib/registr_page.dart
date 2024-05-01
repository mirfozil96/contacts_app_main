
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ro\'yxatdan o\'tish')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
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
                box.put('username', username); // Foydalanuvchi nomini saqlash
                box.put('password', password); // Parolni saqlash
                Navigator.of(context).pop();
              },
              child: const Text('Ro\'yxatdan o\'tish'),
            ),
          ],
        ),
      ),
    );
  }
}
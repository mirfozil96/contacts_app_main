import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'languange_servise.dart';
import 'login_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late String _currentUsername;
  late String _currentPassword;

  @override
  void initState() {
    super.initState();
    _currentUsername = Hive.box('myBox').get('username', defaultValue: '');
    _currentPassword = Hive.box('myBox').get('password', defaultValue: '');
    _usernameController.text = _currentUsername;
    _passwordController.text = _currentPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings'.tr)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'username: $_currentUsername',
                labelStyle: const TextStyle(
                    color: Colors.white70), // Label matni rangi oq
                // Matn va kiritish qutisi rangi oq
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70),
                ),
                // Matn rangi oq
                hintStyle: const TextStyle(color: Colors.white70),
                filled: true, // TextField ichi boyalsa
                fillColor: Colors.white
                    .withOpacity(0.2), // TextField ichining rangi vaurchi
              ),
              style: const TextStyle(
                  color: Colors.white), // Kiritish qutisi matni rangi oq
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'password: $_currentPassword',
                labelStyle: const TextStyle(
                    color: Colors.white70), // Label matni rangi oq
                // Matn va kiritish qutisi rangi oq
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70),
                ),
                // Matn rangi oq
                hintStyle: const TextStyle(color: Colors.white70),
                filled: true, // TextField ichi boyalsa
                fillColor: Colors.white
                    .withOpacity(0.2), // TextField ichining rangi vaurchi
              ),
              style: const TextStyle(
                  color: Colors.white), // Kiritish qutisi matni rangi oq
            ),
            ElevatedButton(
              onPressed: () {
                final newUsername = _usernameController.text;
                final newPassword = _passwordController.text;
                var box = Hive.box('myBox');
                box.put('username', newUsername);
                box.put('password', newPassword);
                setState(() {
                  _currentUsername = newUsername;
                  _currentPassword = newPassword;
                });
              },
              child: Text('Save'.tr),
            ),
            ElevatedButton(
              onPressed: () {
                Hive.box('myBox').delete('isLoggedIn');
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => LoginPage()));
              },
              child: Text('Exit'.tr),
            ),
          ],
        ),
      ),
    );
  }
}

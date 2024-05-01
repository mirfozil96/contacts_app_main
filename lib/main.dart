import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'bottombar_page.dart';
import 'languange_servise.dart';
import 'login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LanguageService.initLanguageService();
  await Hive.initFlutter();
  var box = await Hive.openBox('myBox');
  bool isLoggedIn = box.get('isLoggedIn', defaultValue: false);
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // scaffoldBackgroundColor: Colors.black12,
        scaffoldBackgroundColor: Colors.blueGrey[900],
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Colors.white,
          ),
          labelMedium: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
      home: isLoggedIn ? const MyHomePage() : LoginPage(),

      // home: const JsonHome(),
    );
  }
}

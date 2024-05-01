import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'home.dart';
import 'languange_servise.dart';
import 'setting_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final String currentUsername =
        Hive.box('myBox').get('username', defaultValue: '');
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            text: 'Welcome!'.tr,
            style: const TextStyle(
              color: Color.fromARGB(179, 45, 126, 65),
              fontSize: 15,
            ),
            children: <TextSpan>[
              const TextSpan(
                text: ':  ',
                style: TextStyle(
                    color: Color.fromARGB(
                        255, 184, 76, 19)), // O'zgartirish mumkin
              ),
              TextSpan(
                text: currentUsername,
                style: const TextStyle(
                    fontSize: 30,
                    color: Color.fromARGB(
                        255, 184, 76, 19)), // O'zgartirish mumkin
              ),
            ],
          ),
        ),
        actions: [
          PopupMenuButton<Language>(
            onSelected: (Language result) {
              setState(() {
                LanguageService.setLanguage(result);
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Language>>[
              const PopupMenuItem<Language>(
                value: Language.uz,
                child: Text('O\'zbekcha'),
              ),
              const PopupMenuItem<Language>(
                value: Language.en,
                child: Text('English'),
              ),
              const PopupMenuItem<Language>(
                value: Language.ru,
                child: Text('Русский'),
              ),
            ],
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          JsonHome(),
          SettingsPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.home), label: 'Home'.tr),
          BottomNavigationBarItem(
              icon: const Icon(Icons.settings), label: 'Settings'.tr),
        ],
      ),
    );
  }
}

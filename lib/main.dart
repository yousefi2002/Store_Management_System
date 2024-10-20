import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_ms/main_page.dart';
import 'package:store_ms/splash_screen.dart';

main() {
  runApp(
   MyApp(),
  );
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;
  double fontSize = 16.0;
  String selectedLanguage = 'English';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
      fontSize = prefs.getDouble('fontSize') ?? 16.0;
      selectedLanguage = prefs.getString('language') ?? 'English';
    });
  }


  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme:  isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: const SplashScreen(),

    );
  }
}

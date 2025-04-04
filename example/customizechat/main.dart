import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Chat Plus Custom Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey[50],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.grey[800]),
          titleTextStyle: TextStyle(
            color: Colors.grey[800],
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1A1A1A),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2D2D2D),
          elevation: 0,
          centerTitle: true,
        ),
      ),
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}

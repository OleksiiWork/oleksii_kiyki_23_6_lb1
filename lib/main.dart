import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oleksii_kiyki_23_6_lb1/screens/tabs_screen.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'University App',
      theme: ThemeData(
        useMaterial3: true,
        // Робимо фон скаффолда прозорим, щоб видно було наш градієнт
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent, // Прозорий AppBar
          elevation: 0, // Без тіні
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color.fromARGB(200, 0, 50, 100), // Напівпрозорий синій
          selectedItemColor: Colors.yellowAccent,
          unselectedItemColor: Colors.white70,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light, // Світла тема як база
        ),
        textTheme: GoogleFonts.latoTextTheme(
           Theme.of(context).textTheme.apply(
             bodyColor: Colors.white, // Білий текст за замовчуванням для контрасту
             displayColor: Colors.white,
           ),
        ),
      ),
      home: const TabsScreen(),
    );
  }
}
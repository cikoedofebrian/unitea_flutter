import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unitea_flutter/views/screens/homescreen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme().copyWith(
          titleMedium: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
          labelMedium:
              const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
        ),
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

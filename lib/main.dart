import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unitea_flutter/controllers/usercontroller.dart';
import 'package:unitea_flutter/views/screens/addnewpost.dart';
import 'package:unitea_flutter/views/screens/commentscreen.dart';
import 'package:unitea_flutter/views/screens/homescreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitea_flutter/views/screens/loginscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UniTea',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme().copyWith(
          titleMedium: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
          titleLarge: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 28, color: Colors.white),
          labelMedium:
              const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
        ),
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
          future: userController.tryAutoLogin(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            return Obx(() {
              if (userController.token.isEmpty) {
                return const LoginScreen();
              }
              return const HomeScreen();
            });
          }),
      getPages: [
        GetPage(name: '/comment', page: () => const CommentScreen()),
        GetPage(name: '/add-post', page: () => const AddNewPostScreen()),
      ],
    );
  }
}

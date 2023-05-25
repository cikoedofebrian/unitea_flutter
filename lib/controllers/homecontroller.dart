import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:unitea_flutter/views/screens/postscreen.dart';
import 'package:unitea_flutter/views/screens/profilescreen.dart';

class HomeController extends GetxController {
  final RxInt _selectedIndex = 0.obs;
  int get selectedIndex => _selectedIndex.value;

  void changeSelectedPage(int index) {
    _selectedIndex.value = index;
  }

  Widget getPage() {
    switch (selectedIndex) {
      case 1:
        return const ProfileScreen();
      default:
        return const PostScreen();
    }
  }
}

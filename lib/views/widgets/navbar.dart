import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/majesticons.dart';
import 'package:unitea_flutter/constants/colors.dart';
import 'package:unitea_flutter/controllers/homecontroller.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    return Container(
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          offset: Offset(0, 4),
          color: Colors.black12,
          spreadRadius: 10,
          blurRadius: 10,
        )
      ]),
      padding: const EdgeInsets.only(bottom: 40, top: 24, left: 20, right: 20),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () => homeController.changeSelectedPage(0),
              child: Iconify(
                Majesticons.messages,
                size: 26,
                color:
                    homeController.selectedIndex == 0 ? primary : Colors.grey,
              ),
            ),
            const SizedBox(),
            InkWell(
              onTap: () => homeController.changeSelectedPage(1),
              child: Icon(
                Icons.person_2_rounded,
                color:
                    homeController.selectedIndex == 1 ? primary : Colors.grey,
                size: 26,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

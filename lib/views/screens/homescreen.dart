import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unitea_flutter/constants/colors.dart';
import 'package:unitea_flutter/controllers/homecontroller.dart';
import 'package:unitea_flutter/controllers/postcontroller.dart';
// import 'package:unitea_flutter/controllers/usercontroller.dart';
import 'package:unitea_flutter/views/widgets/navbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final postController = Get.put(PostController());
    final homeController = Get.put(HomeController());
    // final UserController userController = Get.find();

    void fetchData() {
      postController.fetchData();
    }

    fetchData();
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(() => !postController.isLoading
          ? Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: Colors.white,
                    width: 8,
                    strokeAlign: BorderSide.strokeAlignOutside),
              ),
              width: 60,
              height: 60,
              child: FloatingActionButton(
                backgroundColor: primary,
                onPressed: () => Get.toNamed('/add-post'),
                child: const Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            )
          : const SizedBox()),
      body: Obx(
        () => postController.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  Obx(() => homeController.getPage()),
                  const Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Navbar(),
                  )
                ],
              ),
      ),
    );
  }
}

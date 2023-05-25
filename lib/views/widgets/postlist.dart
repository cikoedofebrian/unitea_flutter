import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unitea_flutter/controllers/homecontroller.dart';
import 'package:unitea_flutter/views/widgets/postitem.dart';

class PostList extends StatelessWidget {
  const PostList({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Obx(
          () => Column(children: [
            const SizedBox(
              height: 20,
            ),
            ...List.generate(
              homeController.list.length,
              (index) => PostItem(data: homeController.list[index]),
            ),
          ]),
        ),
      ),
    );
  }
}

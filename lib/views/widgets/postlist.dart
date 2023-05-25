import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unitea_flutter/controllers/postcontroller.dart';
import 'package:unitea_flutter/views/widgets/postitem.dart';

class PostList extends StatelessWidget {
  const PostList({super.key});

  @override
  Widget build(BuildContext context) {
    final PostController homeController = Get.find();
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          ...List.generate(
            homeController.list.length,
            (index) => PostItem(
              index: index,
            ),
          ),
          const SizedBox(
            height: 100,
          ),
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unitea_flutter/constants/colors.dart';
import 'package:unitea_flutter/controllers/postcontroller.dart';
import 'package:unitea_flutter/views/widgets/facultiespicker.dart';
import 'package:unitea_flutter/views/widgets/postlist.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PostController postController = Get.find();
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          floating: false,
          backgroundColor: primary,
          expandedHeight: MediaQuery.of(context).size.height * 0.12,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Expanded(
                      child: Text(
                        'UniTea',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    FacultiesPicker(),
                  ]),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (_, int index) {
              return Obx(
                () => postController.list.isEmpty
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Belum ada post untuk fakultas ini!',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontSize: 20),
                            ),
                            const Text(
                                'Tambahkan gibahan berfaedah mu disini!'),
                          ],
                        ),
                      )
                    : const PostList(),
              );
            },
            childCount: 1,
          ),
        ),
      ],
    );
  }
}

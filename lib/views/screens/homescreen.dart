import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:unitea_flutter/constants/colors.dart';
import 'package:unitea_flutter/controllers/homecontroller.dart';
import 'package:unitea_flutter/views/widgets/facultiespicker.dart';
import 'package:unitea_flutter/views/widgets/postitem.dart';
import 'package:unitea_flutter/views/widgets/postlist.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    return Scaffold(
      body: FutureBuilder(
          future: homeController.fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
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
                      return const PostList();
                    },
                    childCount: 1,
                  ),
                ),
              ],
            );
          }),
    );
  }
}

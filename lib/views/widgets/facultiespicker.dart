import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:unitea_flutter/controllers/postcontroller.dart';

class FacultiesPicker extends StatelessWidget {
  const FacultiesPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final PostController homeController = Get.find();
    return InkWell(
      onTap: () {
        int selectedFaculty = homeController.selectedFacultyIndex;
        showCupertinoModalPopup(
          context: context,
          builder: (context) => CupertinoActionSheet(
            cancelButton: CupertinoActionSheetAction(
              onPressed: () => Get.back(result: selectedFaculty),
              child: const Text('Kembali'),
            ),
            actions: [
              SizedBox(
                height: 200,
                child: CupertinoPicker(
                    itemExtent: 40,
                    onSelectedItemChanged: (value) {
                      selectedFaculty = value;
                    },
                    scrollController: FixedExtentScrollController(
                        initialItem: homeController.selectedFacultyIndex),
                    children: [
                      ...homeController.facultyList
                          .map(
                            (e) => Center(
                              child: Text(
                                e.name,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                          .toList()
                    ]),
              )
            ],
          ),
        ).then((value) {
          if (value != null && value != homeController.selectedFacultyIndex) {
            homeController.fetchDataBasedOnFaculty(value);
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color.fromRGBO(50, 105, 205, 1),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          child: Row(children: [
            Obx(
              () => Text(
                homeController
                    .facultyList[homeController.selectedFacultyIndex].name,
                style: const TextStyle(fontSize: 10),
              ),
            ),
            const Icon(
              Icons.arrow_drop_down_rounded,
              color: Colors.white,
            )
          ]),
        ),
      ),
    );
  }
}

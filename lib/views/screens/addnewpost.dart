import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'dart:convert';
import 'package:unitea_flutter/constants/colors.dart';
import 'package:unitea_flutter/controllers/postcontroller.dart';
import 'package:unitea_flutter/views/widgets/customdialog.dart';

class AddNewPostScreen extends StatefulWidget {
  const AddNewPostScreen({super.key});

  @override
  State<AddNewPostScreen> createState() => _AddNewPostScreenState();
}

class _AddNewPostScreenState extends State<AddNewPostScreen> {
  int selectedFacultyIndex = 0;
  PostController postController = Get.find();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    super.initState();
  }

  void tryParse() {
    try {
      BigInt n = BigInt.from(19829);
      int l = (log(n.toDouble()) / log(2)).ceil();
      BigInt e = BigInt.from(6911);
      String plain = "Hello World";
      List<int> plainBytes = utf8.encode(plain);
      String cipherBinary = '';
      for (int x in plainBytes) {
        BigInt biX = BigInt.from(x);
        BigInt biResult = biX.modPow(e, n);
        cipherBinary += biResult.toRadixString(2).padLeft(l, '0');
      }
      while (cipherBinary.length % 8 > 0) {
        cipherBinary += '0';
      }
      List<int> cipherBytes = [];
      for (int i = 0; i < cipherBinary.length; i += 8) {
        String tmp = cipherBinary.substring(i, i + 8);
        int value = int.parse(tmp, radix: 2);
        cipherBytes.add(value);
      }

      String cipherBase64 = base64.encode(cipherBytes);
      print('Encrypted Message: $cipherBase64');
    } catch (error) {
      print(error);
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void trySave() {
      if (_descriptionController.text.isEmpty ||
          _titleController.text.isEmpty) {
        customDialog(context, "Data tidak boleh kosong!").show(context);
        return;
      }
      postController.addNewPost(_titleController.text,
          _descriptionController.text, selectedFacultyIndex);
    }

    return Scaffold(
      backgroundColor: primary,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Judul',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: secondary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: _titleController,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(fontWeight: FontWeight.w300),
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 14),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Deskripsi',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: secondary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: _descriptionController,
                            maxLines: 10,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(fontWeight: FontWeight.w300),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 14),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Pilih Fakultas',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            int temporaryIndex = selectedFacultyIndex;
                            showCupertinoModalPopup(
                              context: context,
                              builder: (context) => CupertinoActionSheet(
                                cancelButton: CupertinoActionSheetAction(
                                  onPressed: () =>
                                      Get.back(result: temporaryIndex),
                                  child: const Text('Kembali'),
                                ),
                                actions: [
                                  SizedBox(
                                    height: 200,
                                    child: CupertinoPicker(
                                        itemExtent: 40,
                                        onSelectedItemChanged: (value) {
                                          temporaryIndex = value;
                                        },
                                        scrollController:
                                            FixedExtentScrollController(
                                                initialItem:
                                                    selectedFacultyIndex),
                                        children: [
                                          ...postController.facultyList
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
                              if (value != null &&
                                  value != selectedFacultyIndex) {
                                setState(() {
                                  selectedFacultyIndex = value;
                                });
                              }
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: secondary,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              postController
                                  .facultyList[selectedFacultyIndex].name,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          // onTap: trySave,
                          onTap: trySave,
                          child: Container(
                            decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            alignment: Alignment.center,
                            width: double.infinity,
                            child: Text(
                              'Buat',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            decoration: const BoxDecoration(color: Colors.white),
            height: MediaQuery.of(context).size.height * 0.16,
            padding: const EdgeInsets.only(left: 12, bottom: 12),
            child: InkWell(
              onTap: () => Get.back(),
              child: Row(
                children: [
                  const Icon(
                    Icons.navigate_before_rounded,
                    size: 60,
                    color: primary,
                  ),
                  Text(
                    'Buat Post',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: primary, fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unitea_flutter/constants/colors.dart';
import 'package:unitea_flutter/controllers/postcontroller.dart';
import 'package:unitea_flutter/controllers/usercontroller.dart';
import 'package:unitea_flutter/views/widgets/customdialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoginPage = true;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _nameController;

  late Future future;
  int selectedFacultyIndex = 0;
  final postController = Get.put(PostController());
  final UserController userController = Get.find();
  @override
  void initState() {
    future = postController.fetchFaculty();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    void trySave() async {
      final email = _emailController.text;
      final password = _passwordController.text;
      final name = _nameController.text;

      if (isLoginPage) {
        if (email.isEmpty || password.isEmpty) {
          customDialog(context, "Data tidak boleh kosong!").show(context);
          return;
        } else if (!EmailValidator.validate(email)) {
          customDialog(context, "Format email salah!").show(context);
          return;
        }
        final isMadeIt = await userController.login(email, password);
        if (isMadeIt == false) {
          // ignore: use_build_context_synchronously
          customDialog(context, "Data anda salah!").show(context);
          return;
        }
      } else {
        if (email.isEmpty || password.isEmpty || name.isEmpty) {
          customDialog(context, "Data tidak boleh kosong!");
          return;
        } else if (password.length < 10) {
          customDialog(context, "Password tidak boleh kurang dari 10!");
        } else if (!EmailValidator.validate(email)) {
          customDialog(context, "Format email salah!").show(context);
          return;
        }
        final facultyId = postController.facultyList[selectedFacultyIndex].id;
        final isMadeIt = await userController.register(
            email, password, facultyId.toString(), name);
        if (isMadeIt != null) {
          // ignore: use_build_context_synchronously
          customDialog(context, isMadeIt).show(context);
          return;
        }
      }
    }

    return Scaffold(
      backgroundColor: primary,
      body: FutureBuilder(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              child: SizedBox(
                height: size.height,
                child: Column(children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.bottomLeft,
                    color: Colors.white,
                    height: size.height * 0.3,
                    child: Text(
                      'Unitea, tempat diskusi kampus berfaedah.',
                      style: textTheme.titleLarge!.copyWith(color: primary),
                    ),
                  ),
                  Container(
                      height: size.height * 0.7,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(isLoginPage ? 'Login' : 'Daftar',
                                  style: textTheme.titleLarge),
                              Row(
                                children: [
                                  Text(isLoginPage ? 'Daftar' : 'Login',
                                      style: textTheme.titleMedium!
                                          .copyWith(color: Colors.white)),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isLoginPage = !isLoginPage;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.navigate_next_rounded,
                                        color: Colors.white,
                                      ))
                                ],
                              ),
                            ],
                          ),
                          Expanded(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: size.width * 0.7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Email',
                                    style: textTheme.titleMedium!
                                        .copyWith(color: Colors.white),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextField(
                                      controller: _emailController,
                                      style: textTheme.labelMedium!.copyWith(
                                          fontWeight: FontWeight.w300),
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 14),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Password',
                                    style: textTheme.titleMedium!
                                        .copyWith(color: Colors.white),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextField(
                                      controller: _passwordController,
                                      style: textTheme.labelMedium!.copyWith(
                                          fontWeight: FontWeight.w300),
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 14),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  if (!isLoginPage) ...[
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Nama',
                                      style: textTheme.titleMedium!
                                          .copyWith(color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: TextField(
                                        controller: _nameController,
                                        style: textTheme.labelMedium!.copyWith(
                                            fontWeight: FontWeight.w300),
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 14),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Fakultas',
                                      style: textTheme.titleMedium!
                                          .copyWith(color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        int temporaryIndex =
                                            selectedFacultyIndex;
                                        showCupertinoModalPopup(
                                          context: context,
                                          builder: (context) =>
                                              CupertinoActionSheet(
                                            cancelButton:
                                                CupertinoActionSheetAction(
                                              onPressed: () => Get.back(
                                                  result: temporaryIndex),
                                              child: const Text('Kembali'),
                                            ),
                                            actions: [
                                              SizedBox(
                                                height: 200,
                                                child: CupertinoPicker(
                                                    itemExtent: 40,
                                                    onSelectedItemChanged:
                                                        (value) {
                                                      temporaryIndex = value;
                                                    },
                                                    scrollController:
                                                        FixedExtentScrollController(
                                                            initialItem:
                                                                selectedFacultyIndex),
                                                    children: [
                                                      ...postController
                                                          .facultyList
                                                          .map(
                                                            (e) => Center(
                                                              child: Text(
                                                                e.name,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 14),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          postController
                                              .facultyList[selectedFacultyIndex]
                                              .name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                        ),
                                      ),
                                    ),
                                  ],
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(
                                    onTap: trySave,
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        isLoginPage ? 'MASUK' : 'DAFTAR',
                                        style: textTheme.titleMedium!
                                            .copyWith(color: primary),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      )),
                ]),
              ),
            );
          }),
    );
  }
}

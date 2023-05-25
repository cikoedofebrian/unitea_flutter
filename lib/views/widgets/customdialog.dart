import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:get/get.dart';
import 'package:unitea_flutter/constants/colors.dart';

NDialog customDialog(BuildContext context, String message) {
  return NDialog(
    title: Column(
      children: [
        Text(
          'Gagal !',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.black,
                fontSize: 20,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          height: 3,
          color: secondary,
        )
      ],
    ),
    content: Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.labelMedium,
      ),
    ),
    actions: [
      InkWell(
        onTap: () => Get.back(),
        child: Container(
          decoration: const BoxDecoration(color: primary),
          alignment: Alignment.center,
          child: Text(
            'Kembali',
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(color: Colors.white),
          ),
        ),
      )
    ],
  );
}

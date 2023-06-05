import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';
import 'package:unitea_flutter/constants/rsa_key.dart';
import 'package:unitea_flutter/controllers/usercontroller.dart';

class Encryptor {
  static String rsaEncryptor(String plainText) {
    BigInt n = BigInt.from(RSAKey.N);
    int l = (log(n.toDouble()) / log(2)).ceil();
    String plain = plainText;
    List<int> plainBytes = utf8.encode(plain);
    String cipherBinary = '';
    for (int x in plainBytes) {
      BigInt biX = BigInt.from(x);
      BigInt biResult = biX.modPow(BigInt.from(RSAKey.publicKey), n);
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
    return cipherBase64;
  }

  static shiftEncryptor(String plainText) {
    final UserController userController = Get.find();
    String alpha =
        ' !"#\$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~';
    String result = '';
    for (int i = 0; i < plainText.length; i++) {
      String letter = plainText[i];
      if (alpha.contains(letter)) {
        int letterIndex =
            (alpha.indexOf(letter) + userController.user.id) % alpha.length;
        result += alpha[letterIndex];
      } else {
        result += letter;
      }
    }
    return result;
  }
}

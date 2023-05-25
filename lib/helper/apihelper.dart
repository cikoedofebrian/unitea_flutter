import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:unitea_flutter/controllers/usercontroller.dart';

class ApiHelper {
  static dynamic sendRequest(String url, String method, dynamic json) async {
    final UserController userController = Get.find();
    late dynamic request;
    switch (method) {
      case "GET":
        request = await http.get(Uri.parse(url),
            headers: {'Authorization': 'Bearer ${userController.token}'});
        break;
      case "POST":
        request = await http.post(Uri.parse(url),
            headers: {'Authorization': 'Bearer ${userController.token}'},
            body: json);
        break;
    }
    return jsonDecode(request.body);
  }
}

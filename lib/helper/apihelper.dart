import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unitea_flutter/constants/token.dart';

class ApiHelper {
  static Future<List<dynamic>> sendRequest(String url) async {
    final request =
        await http.get(Uri.parse(url), headers: {'Authorization': authToken});
    return jsonDecode(request.body);
  }
}

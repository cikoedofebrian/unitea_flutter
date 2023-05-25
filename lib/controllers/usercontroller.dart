import 'package:get/state_manager.dart';
import 'package:unitea_flutter/constants/api.dart';
import 'package:unitea_flutter/controllers/base.dart';
import 'package:unitea_flutter/helper/apihelper.dart';
import 'package:unitea_flutter/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends BaseController {
  Rx<User>? _user;
  User get user => _user!.value;

  final RxString _token = ''.obs;
  String get token => _token.value;

  Future<void> tryAutoLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? savedToken = prefs.getString('token');

    if (savedToken != null) {
      _token.value = savedToken;
    }

    final decodedData = await ApiHelper.sendRequest(getUser, 'GET', null);
    _user = User.fromJson(decodedData).obs;
    setLoading(false);
  }

  Future<bool> login(String email, String password) async {
    final decodedData = await ApiHelper.sendRequest(
        getLogin, "POST", {'email': email, 'password': password});

    if (decodedData['error'] != null) {
      return false;
    } else if (decodedData['message'] == "Invalid login details") {
      return false;
    }
    _user = User.fromJson(decodedData['user']).obs;
    _token.value = decodedData['access_token'];

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', _token.value);
    return true;
  }

  Future<String?> register(
    String email,
    String password,
    String faculty,
    String name,
  ) async {
    final decodedData = await ApiHelper.sendRequest(getRegister, "POST", {
      'email': email,
      'password': password,
      'name': name,
      'faculty_id': faculty
    });
    if (decodedData['error'] != null) {
      if (decodedData['error']['email'][0] ==
          "The email has already been taken.") {
        return "Email sudah terdaftar!";
      }
      return "Data anda memiliki kesalahan format!";
    }

    _user = User.fromJson(decodedData['user']).obs;
    _token.value = decodedData['access_token'];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', _token.value);
    return null;
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    _token.value = '';
    prefs.remove('token');
    prefs.clear();
  }
}

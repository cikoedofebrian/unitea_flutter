import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:unitea_flutter/constants/api.dart';
import 'package:unitea_flutter/controllers/base.dart';
import 'package:unitea_flutter/helper/apihelper.dart';
import 'package:unitea_flutter/models/faculty.dart';
import 'package:unitea_flutter/models/post.dart';

class HomeController extends BaseController {
  final RxList<Post> _list = <Post>[].obs;
  List<Post> get list => _list;

  final RxList<Faculty> _facultyList = <Faculty>[].obs;
  List<Faculty> get facultyList => _facultyList;

  RxInt? _selectedFacultyIndex;
  int get selectedFacultyIndex => _selectedFacultyIndex!.value;
  changeFaculty(int value) {
    _selectedFacultyIndex!.value = value;
  }

  Future<void> fetchData() async {
    try {
      _list.value = [];

      // final result = await http.get(Uri.parse(getPosts), headers: {
      //   'Authorization': 'Bearer z5Jtv8w21h2cQ25ibKIDk4RrsmO4734uJSquXxLI'
      // });
      // final decodedResult = await jsonDecode(result.body);
      final decodedResult = await ApiHelper.sendRequest(getPosts);
      for (var i in decodedResult) {
        _list.add(Post.fromJson(i));
      }
      // final faculties = await http.get(Uri.parse(getFaculties), headers: {
      //   'Authorization': 'Bearer z5Jtv8w21h2cQ25ibKIDk4RrsmO4734uJSquXxLI'
      // });
      // final decodedFaculties = jsonDecode(faculties.body);

      final decodedFaculties = await ApiHelper.sendRequest(getFaculties);

      for (var i in decodedFaculties) {
        _facultyList.add(Faculty.fromJson(i));
      }
      _selectedFacultyIndex = 0.obs;
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchDataBasedOnFaculty(int index) async {
    _list.value = [];
    final result = await http
        .get(Uri.parse("$getPosts/${_facultyList[index].id}"), headers: {
      'Authorization': 'Bearer z5Jtv8w21h2cQ25ibKIDk4RrsmO4734uJSquXxLI'
    });
    final decodedResult = jsonDecode(result.body);
    for (var i in decodedResult) {
      _list.add(Post.fromJson(i));
    }
    _selectedFacultyIndex!.value = index;
  }
}

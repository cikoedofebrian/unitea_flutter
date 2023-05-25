import 'package:get/get.dart';
import 'package:unitea_flutter/constants/api.dart';
import 'package:unitea_flutter/controllers/base.dart';
import 'package:unitea_flutter/helper/apihelper.dart';
import 'package:unitea_flutter/models/comment.dart';
import 'package:unitea_flutter/models/faculty.dart';
import 'package:unitea_flutter/models/post.dart';

class PostController extends BaseController {
  final RxList<Post> _list = <Post>[].obs;
  List<Post> get list => _list;

  final RxList<Comment> _commentList = <Comment>[].obs;
  List<Comment> get commentList => _commentList;

  final RxList<Faculty> _facultyList = <Faculty>[].obs;
  List<Faculty> get facultyList => _facultyList;

  RxInt? _selectedFacultyIndex;
  int get selectedFacultyIndex => _selectedFacultyIndex!.value;
  changeFaculty(int value) {
    _selectedFacultyIndex!.value = value;
  }

  Future<void> fetchData() async {
    _list.value = [];
    final decodedResult = await ApiHelper.sendRequest(getPosts, "GET", null);
    for (var i in decodedResult) {
      _list.add(Post.fromJson(i));
    }
    await fetchFaculty().then((value) => setLoading(false));
  }

  Future<void> fetchFaculty() async {
    _facultyList.value = [];
    final decodedFaculties =
        await ApiHelper.sendRequest(getFaculties, "GET", null);
    for (var i in decodedFaculties) {
      _facultyList.add(Faculty.fromJson(i));
    }
    _selectedFacultyIndex = 0.obs;
    _facultyList.refresh();
  }

  Future<void> fetchDataBasedOnFaculty(int index) async {
    _list.value = [];
    String url = "$getPosts/${_facultyList[index].id}";
    if (index == 0) {
      url = getPosts;
    }
    final decodedResult = await ApiHelper.sendRequest(url, "GET", null);
    for (var i in decodedResult) {
      _list.add(Post.fromJson(i));
    }
    _selectedFacultyIndex!.value = index;
  }

  Future<void> addNewPost(
    String title,
    String content,
    int faculty,
  ) async {
    final decodedData = await ApiHelper.sendRequest(getPosts, "POST", {
      'title': title,
      'faculty_id': facultyList[faculty].id.toString(),
      'content': content,
    });

    _list.add(Post.fromJson(decodedData['body']));
    _list.refresh();
    Get.back();
  }

  Future<void> likePost(int id) async {
    final String url = '$getPosts/$id/like';
    final decodedResult = await ApiHelper.sendRequest(url, "GET", null);
    final postIndex = _list.indexWhere((element) => element.id == id);

    if (decodedResult['status'] == 'deleted') {
      _list[postIndex].isliked = false;
      _list[postIndex].likes -= 1;
    } else {
      _list[postIndex].isliked = true;
      _list[postIndex].likes += 1;
    }
    _list.refresh();
  }

  Future<void> fetchCommentData(String id) async {
    _commentList.value = [];
    final decodedData =
        await ApiHelper.sendRequest("$getComments/$id", "GET", null);
    for (var i in decodedData) {
      _commentList.add(Comment.fromJson(i));
    }
  }

  Future<void> addNewComment(String content, int postId) async {
    final decodedData = await ApiHelper.sendRequest(getComments, "POST", {
      'post_id': postId.toString(),
      'content': content,
    });
    final postIndex = list.indexWhere((element) => element.id == postId);
    _list[postIndex].comments += 1;
    commentList.add(Comment.fromJson(decodedData['data']));
    _list.refresh();
  }
}

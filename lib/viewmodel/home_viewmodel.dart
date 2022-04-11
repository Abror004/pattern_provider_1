// import 'package:flutter/cupertino.dart';
// import 'package:pattern_provider_1/model/post_model.dart';
// import 'package:pattern_provider_1/service/http_service.dart';
//
// class HomeViewModel extends ChangeNotifier {
//   bool isLoading = false;
//   List<Post> items = [];
//
//   Future apiPostList() async {
//     isLoading = true;
//     notifyListeners();
//
//     var response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
//     if(response != null) {
//       items = Network.parsePostList(response);
//     } else {
//       items = [];
//     }
//     isLoading = false;
//   }
//
//   Future apiPostDelete(Post post) async {
//       isLoading = true;
//     var response = await Network.DEL(Network.API_DELETE + post.id.toString(), Network.paramsEmpty());
//       if(response != null) {
//         // _apiPostList();
//         print(true);
//       }
//       isLoading = false;
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pattern_provider_1/model/post_model.dart';
import 'package:pattern_provider_1/pages/edit_page.dart';
import 'package:pattern_provider_1/service/http_service.dart';

class HomeViewModel extends ChangeNotifier{
  bool isLoading = false;
  List<Post> items = [];

  void apiPostList() {
    isLoading = true;
    notifyListeners();
    Network.GET(Network.API_LIST, Network.paramsEmpty()).then((response) => {
      _showResponse(response!),
    });
  }

  void _showResponse(String response) {
    List<Post> list = Network.parsePostList(response);
    items.clear();
    isLoading = false;
    items = list;
    notifyListeners();

  }

  Future apiPostDelete(Post post) async {
    isLoading = true;
    notifyListeners();
    var response = await Network.DEL(
        Network.API_DELETE + post.id.toString(), Network.paramsEmpty());
    if (response != null) {
      items.remove(post);
    }
    isLoading = false;
    notifyListeners();
    Timer(const Duration(seconds: 2), () => apiPostList());
    notifyListeners();
  }

  // Future goToCreatePage(BuildContext context) async{
  //   String? result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CreatePage()));
  //   if(result == null) return;
  //   items.add(Network.parsePost(result));
  //   notifyListeners();
  // }

  Future goToEditPage(Post post,BuildContext context) async {
    Map? result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Edit_Page(post: post,)));
    print(result);
    if(result!["post"] != null) {
      Post newPost = result["post"];
      items[items.indexWhere((element) => element.id == newPost.id)] = newPost;
    }notifyListeners();
    Timer(const Duration(seconds: 2), () => apiPostList());
    notifyListeners();
  }

}
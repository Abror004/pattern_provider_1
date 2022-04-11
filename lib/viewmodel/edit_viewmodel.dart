import 'package:flutter/cupertino.dart';
import 'package:pattern_provider_1/model/post_model.dart';
import 'package:pattern_provider_1/service/http_service.dart';

class EditViewModel extends ChangeNotifier {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  Post post = Post();

  void save(BuildContext context) async {
    if(titleController.text != "" && bodyController.text != "") {
      post.title = titleController.text;
      post.body = bodyController.text;
      await Network.PUT(Network.API_UPDATE, Network.paramsUpdate(post));
      Navigator.pop(context, {"post": post});
      notifyListeners();
    }
  }

  void editText(String text) {
    print(text);
    notifyListeners();
  }
}
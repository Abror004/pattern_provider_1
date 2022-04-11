import 'package:flutter/material.dart';
import 'package:pattern_provider_1/model/post_model.dart';
import 'package:pattern_provider_1/viewmodel/edit_viewmodel.dart';
import 'package:provider/provider.dart';

class Edit_Page extends StatefulWidget {
  static const String id = "edit_page";

  Post? post;

  Edit_Page({this.post});

  @override
  _Edit_PageState createState() => _Edit_PageState();
}

class _Edit_PageState extends State<Edit_Page> {
  EditViewModel editViewModel = EditViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    editViewModel.post = widget.post!;
    editViewModel.titleController.text = widget.post!.title!;
    editViewModel.bodyController.text = widget.post!.body!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit"),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              editViewModel.save(context);
              },
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: ChangeNotifierProvider(
        create: (context) => editViewModel,
        child: Consumer<EditViewModel>(
          builder: (ctx, model, index) => SingleChildScrollView(
            primary: true,
            physics: ScrollPhysics(),
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Text("title",style: TextStyle(fontSize: 25,color: Colors.blue),),
                TextField(
                  controller: editViewModel.titleController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    hintText: "Title",
                    hintStyle: TextStyle(color: Colors.grey),
                    // border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                  style: TextStyle(fontSize: 18,color: Colors.black),
                  maxLines: (editViewModel.titleController.value.text.length/35).toInt()+1,
                  onChanged: (text) {
                    editViewModel.editText(text);
                  }
                ),
                Text("body",style: TextStyle(fontSize: 25,color: Colors.blue),),
                TextField(
                  controller: editViewModel.bodyController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    hintText: "body",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  style: TextStyle(fontSize: 18,color: Colors.black),
                  maxLines: (double.maxFinite).toInt(),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}

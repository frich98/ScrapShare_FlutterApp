import "dart:io";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../components/widgets/general_appbars.dart';
import '../components/widgets/photo_screen_button.dart';

import '../screens/new_post_screen.dart';

class PhotoScreen extends StatefulWidget{

  static const routeName = "photoscreen";

  final CollectionReference postsRef;
  PhotoScreen({this.postsRef});

  @override
  PhotoScreenState createState() => PhotoScreenState();
}

class PhotoScreenState extends State<PhotoScreen>{

  File image;
  final picker = ImagePicker();
  String imageURL;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: GeneralAppbars.getAppBarBasic(true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [PhotoScreenButton(getImageForPost: _getImageForPost,)]
      )
    );
  }

  void _getImageForPost(BuildContext context) async {

    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    image =  File(pickedFile.path);
    setState(() {});

    _goToNewPostScreen();
  }

  void _goToNewPostScreen() {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => 
        NewPostScreen(imageFile:  image, postsRef: widget.postsRef)
      )
    );
  }



}
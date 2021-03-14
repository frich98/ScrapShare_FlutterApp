import "dart:io";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../components/widgets/general_appbars.dart';

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
        children: [_buttonRow(context)]
      )
    );
  }

  Widget _buttonRow(BuildContext context){
    return Row(        
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
            height: 100, width: 300,
            child: _button(context)
          )
        )
    ]);
  }

  Widget _button(BuildContext context){
    return Semantics(
      label: 'Choose a photo from your photo gallery which will direct you to create a new post with it',
      hint: 'Press to choose a photo from your gallery for your new post',
      enabled: true,
      button: true,
      child: ElevatedButton(
        style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.purple[100])
      ),
      child: _buttonText(context),
      onPressed: () =>  _goToNewPostScreen(context)
    )
    );
  }

  Widget _buttonText(BuildContext context){
    return Text(
      "Get Photo From Gallery", 
      style: TextStyle(
        fontSize: 25,
        color: Colors.purple[600]
      )
    );
  }

  void _goToNewPostScreen(BuildContext context) async {

    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    File imageFile =  File(pickedFile.path);
    setState(() {});
 
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => 
        NewPostScreen(imageFile:  imageFile, postsRef: widget.postsRef)
      )
    );
  }



}
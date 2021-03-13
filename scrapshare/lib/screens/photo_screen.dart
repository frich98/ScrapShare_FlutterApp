import "dart:io";

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

import '../components/general_appbar.dart';

import '../screens/new_post_screen.dart';

class PhotoScreen extends StatefulWidget{

  static const routeName = "photoscreen";

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
      appBar: GeneralAppBar.getAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [_row(context)]
      )
    );
  }

  Widget _row(BuildContext context){
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
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.purple[100])
      ),
      child: _buttonText(context),
      onPressed: () =>  getImage()
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

  void _goToNewPostScreen(BuildContext context, String imageURL) async {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => NewPostScreen(imageURL: imageURL))
    );
  }

  Future getImage() async { 
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    image = File(pickedFile.path);
    setState(() {});

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child(Path.basename(image.path));
    UploadTask uploadTask = ref.putFile(image);

    uploadTask.then( (res) async {
      imageURL = await res.ref.getDownloadURL();
      setState(() {});
       _goToNewPostScreen(context, imageURL);
    });
  }


}
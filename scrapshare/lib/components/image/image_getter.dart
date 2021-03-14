import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;

import '../widgets/new_post_image_null_url.dart';
import '../widgets/new_post_image_not_null_url.dart';

class ImageGetter extends StatefulWidget{

  final Function(String) setImageURL;
  final File imageFile;
  ImageGetter({Key key, this.setImageURL, this.imageFile}) : super(key: key);

  @override
  ImageGetterState createState() => ImageGetterState();
}

class ImageGetterState extends State<ImageGetter>{

  String imageURL;
  bool isLoading = true;

  @override
  initState(){
    super.initState();
    _loadImageGetURL();
  }

  Widget build(BuildContext context){    
    widget.setImageURL(imageURL);
    if(!isLoading){
      return NewPostImageNotNull(imageURL: imageURL);
    } else{
      return NewPostImageNull();
    }  
  }

  void _loadImageGetURL() async { 
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child(Path.basename(widget.imageFile.path));
    UploadTask uploadTask = ref.putFile(widget.imageFile);

    uploadTask.then( (res) async {
      imageURL = await res.ref.getDownloadURL();
      setState((){isLoading = false;});
    });
  }

}
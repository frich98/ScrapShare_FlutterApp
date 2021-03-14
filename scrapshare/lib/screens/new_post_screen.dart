import "dart:io";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


import '../components/location/device_location.dart';
import '../components/widgets/general_appbars.dart';
import '../components/widgets/new_post_list_view.dart';

import '../models/post.dart';

import 'list_screen.dart';

class NewPostScreen extends StatefulWidget{

  static const routeName = "newpostscreen";

  final File imageFile;
  final CollectionReference postsRef;
  NewPostScreen({this.imageFile, this.postsRef});

  @override
  NewPostScreenState createState() => NewPostScreenState();
}

class NewPostScreenState extends State<NewPostScreen>{

  final formKey = GlobalKey<FormState>();

  DeviceLocation deviceLocation;

  String imageURL;
  int quantity;

  FocusNode quantityFocusNode;

  @override
  void initState(){
    super.initState();
    quantityFocusNode = FocusNode();
    deviceLocation = DeviceLocation();
    setState((){});
  }

  @override
  void dispose() {
    quantityFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: GeneralAppbars.getAppBarIfImage(_goToListScreen),
        body: Container( 
        padding: EdgeInsets.all(20),
        child: NewPostListView(
          focusNode: quantityFocusNode, imageFile: widget.imageFile, 
          formKey: formKey, setImageURL: _setImageURL,
          setQuantity: _setQuantity, saveOnPressed: _saveOnPressed
        )
      )
    );    
  }



 void _saveOnPressed() async {
    if(formKey.currentState.validate() && imageURL != null){
      formKey.currentState.save();
      Post post = Post(
        date: DateTime.now(),
        imageURL: imageURL,
        quantity: quantity,
        latitude: deviceLocation.locationData.latitude,
        longitude: deviceLocation.locationData.longitude
      );
      
      addPost(post);

      _goToListScreen(context);

    }
  }

  Future<void> addPost(Post post){
    return widget.postsRef.add({
      'date': post.date,
      'imageURL': post.imageURL,
      'quantity': post.quantity,
      'latitude': post.latitude,
      'longitude': post.longitude
    })
    .then( (value) => print("Post Added"))
    .catchError( (error) => print("Failed to add post: $error"));
  }

  void _goToListScreen(BuildContext context){
    Navigator.push(context, 
      MaterialPageRoute(builder: (context) => ListScreen())
    );
  }

  void _setQuantity(int val){
    quantity = val;
  }

  void _setImageURL(String url){
    imageURL = url;
  }

}
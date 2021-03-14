import "dart:io";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/image/image_getter.dart';
import '../components/location/device_location.dart';
import '../components/widgets/general_appbars.dart';
import '../components/widgets/new_post_quantity_form_field.dart';

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

  ImageGetter image;
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
    return _scaffoldBodyIfImage(context);    
  }

  Widget _scaffoldBodyIfImage(BuildContext context){
    return Scaffold(
        appBar: GeneralAppbars.getAppBarIfImage(_goToListScreen),
        body: Container( 
        padding: EdgeInsets.all(20),
        child:_listView(context),
      )
    );
  }

  Widget _listView(BuildContext context){
    return  ListView(
      children: [
        SizedBox(height: 20),
        ImageGetter(setImageURL: _setImageURL, imageFile: widget.imageFile),
        SizedBox(height: 20),
        _numItemsText(context),
        SizedBox(height: 20),
        NewPostQuantityFormField(formKey, quantityFocusNode, _setQuantity),
        SizedBox(height: 40),
        _elevatedButton(context)
      ]
    );
  }

  Widget _numItemsText(BuildContext context){
    return Center(
      child: Text("Number of Items: ",
      style: TextStyle(
        fontSize: 25,
        fontStyle: FontStyle.italic,
        color: Colors.grey[600])
      )
    );
  }

  Widget _elevatedButton(BuildContext context){
    return Container(
      width: 350, height: 50,
      child: Semantics( 
        label: 'Save New Post',
        hint: 'Press to save your new post',
        enabled: true,
        button: true,            
        child: ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.purple[500])),
          onPressed: () => _saveOnPressed(),
          child: Text("Upload Post!", style: TextStyle(fontSize: 30)
        )
      ))
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

      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => ListScreen())
      );
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
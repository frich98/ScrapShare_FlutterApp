import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:path/path.dart' as Path;

import '../components/general_appbars.dart';

import '../models/post.dart';
import '../functions/validate_nonempty_text.dart';

import 'list_screen.dart';

class NewPostScreen extends StatefulWidget{

  static const routeName = "newpostscreen";

  final picker = ImagePicker();
  final File imageFile;

  final CollectionReference postsRef;
  NewPostScreen({this.imageFile, this.postsRef});

  @override
  NewPostScreenState createState() => NewPostScreenState();
}

class NewPostScreenState extends State<NewPostScreen>{

  final formKey = GlobalKey<FormState>();

  LocationData locationData;
  var locationService = Location(); 

  int quantity;
  String imageURL;

  FocusNode quantityFocusNode;

  @override
  void initState(){
    super.initState();
    quantityFocusNode = FocusNode();
    _getLocation();
    _getImage();
  }

  @override
  void dispose() {
    quantityFocusNode.dispose();
    super.dispose();
  }

  void _getLocation() async {
    try {
      var _serviceEnabled = await locationService.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await locationService.requestService();
        if (!_serviceEnabled) {
          print('Failed to enable service. Returning.');
          return;
        }
      }

      var _permissionGranted = await locationService.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await locationService.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          print('Location service permission not granted. Returning.');
        }
      }

      locationData = await locationService.getLocation();
    } on PlatformException catch (e) {
      print('Error: ${e.toString()}, code: ${e.code}');
      locationData = null;
    }
    locationData = await locationService.getLocation();
    print(locationData.latitude);
    setState(() {});
  }

  @override
  Widget build(BuildContext context){
    if(_isImageURLNull()){
      return _scaffoldBodyIfImageNull(context);
    } else {
      return _scaffoldBodyIfImage(context);
    }
  }

  bool _isImageURLNull(){
    return imageURL == null;
  }

  Widget _scaffoldBodyIfImageNull(BuildContext context){
    return Scaffold(
        appBar: GeneralAppbars.getAppBarIfImageNull(_goToListScreen),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text("Loading image...", style: TextStyle(fontSize: 35, color: Colors.purple[600]))),
            SizedBox(height: 100),
            CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.purple[600]))    
          ]
        )
      );
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
        _imageRow(context),        
        SizedBox(height: 20),
        _numItemsText(context),
        SizedBox(height: 20),
        _quantityFormFieldRow(context),
        SizedBox(height: 40),
        _elevatedButton(context)
      ]
    );
  }

  Widget _imageRow(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.purple[500])),
          child: Image.network(imageURL, height: 250, width: 350)),
      ]
    );
  }

  Widget _quantityFormFieldRow(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, 
      children: [
         _quantityFormField(context)
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


  void _getImage() async { 

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child(Path.basename(widget.imageFile.path));
    UploadTask uploadTask = ref.putFile(widget.imageFile);

    uploadTask.then( (res) async {
      imageURL = await res.ref.getDownloadURL();
    });
  }


 void _saveOnPressed() async {
    if(formKey.currentState.validate()){

      formKey.currentState.save();

      Post post = Post(
        date: DateTime.now(),
        imageURL: imageURL,
        quantity: quantity,
        latitude: locationData.latitude,
        longitude: locationData.longitude
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

 Widget _quantityFormField(BuildContext context){
    return Semantics(
      label: 'Scrap quantity form field',
      hint: 'Tap to enter the quantity of scrap items, the numerpad will appear when tapped',
      enabled: true,
      textField: true,      
      child: Container(
      width: 200, height: 100,
      child: Form(
        key: formKey,
        child: TextFormField(
          focusNode: quantityFocusNode,
          decoration: titleDecoration(),
          validator: (value) => validateText(value),
          onTap: () => quantityFocusNode.requestFocus(),
          onSaved: (value) => _setQuantity(int.parse(value)),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25),
          keyboardType: TextInputType.number
        )
      )
    )
    );    
  }

  InputDecoration titleDecoration(){
    return InputDecoration(
      labelText: '',
      labelStyle: TextStyle(
        color: Colors.grey,
      ),
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.purple[300])
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.teal[300])
      ),
      contentPadding: new EdgeInsets.symmetric(vertical: 10, horizontal: 10)
    );
  }

}
import 'package:flutter/material.dart';

import '../components/general_appbar.dart';

class NewPostScreen extends StatefulWidget{

  static const routeName = "newpostscreen";

  final String imageURL;
  NewPostScreen({this.imageURL});

  @override
  NewPostScreenState createState() => NewPostScreenState();
}

class NewPostScreenState extends State<NewPostScreen>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: GeneralAppBar.getAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.imageURL)
        ]
      )
    );
  }

}
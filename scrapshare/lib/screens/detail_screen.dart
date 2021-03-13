import 'dart:ui';

import 'package:flutter/material.dart';

import '../functions/format_date.dart';
import '../models/post.dart';

class DetailScreen extends StatefulWidget{

  static const routeName = "detailscreen";

  final Post post;
  DetailScreen({this.post});

  @override
  DetailScreenState createState() => DetailScreenState();
}

class DetailScreenState extends State<DetailScreen>{

  Image image;

  @override
  void initState() {
    super.initState();
    _setImage();
  }

  Future<Image> _getImage() async {
    return Image.network(widget.post.imageURL, height: 250, width: 350);
  }

  void _setImage() async {
    image =  await _getImage();
    setState((){});
  }


  Widget build(BuildContext context){


    if(image == null)
    {
      return Scaffold(
      appBar: AppBar(
        title: Text("ScrapShare"),
        centerTitle: true,
        backgroundColor: Colors.purple[300],
      ),
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
    
    return Scaffold(
      appBar: AppBar(
        title: Text("ScrapShare"),
        centerTitle: true, 
        backgroundColor: Colors.purple[300],
      ), 
      body: Center(
        child: ListView(
          children: [
            SizedBox(height: 20),
            dateDisplay(context),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.purple[500])),
                child: image),
             ]
            ), 
          SizedBox(height: 20),
          Center(child: Text("Items: " + widget.post.quantity.toString(), style: TextStyle(fontSize: 30),)),
          SizedBox(height: 20),
          Center(child: Text("(" + widget.post.latitude.toStringAsFixed(3) + ", " + widget.post.longitude.toStringAsFixed(3) + ")", style: TextStyle(fontSize: 30),)),         
        ]
        )
      )
    );
  }

  Widget dateDisplay(BuildContext context){
    return Text(
      formatDate(widget.post.date),
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w500
      )
    );
  }



}
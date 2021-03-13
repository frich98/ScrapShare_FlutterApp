import 'package:flutter/material.dart';

import '../functions/format_date.dart';
import '../models/post.dart';

class DetailScreen extends StatelessWidget{

  static const routeName = "detailscreen";

  final Post post;
  DetailScreen({this.post});

  Widget build(BuildContext context){
    
    return Scaffold(
      appBar: AppBar(
        title: Text("ScrapShare"),
        centerTitle: true, 
        backgroundColor: Colors.purple[300],
      ), 
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10),
            dateDisplay(context),
            SizedBox(height: 10)
        ]
        )
      )
    );
  }

  Widget dateDisplay(BuildContext context){
    return Text(
      formatDate(post.date),
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w500
      )
    );
  }



}
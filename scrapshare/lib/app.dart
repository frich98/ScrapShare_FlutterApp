import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './screens/homepage_screen.dart';

class App extends StatefulWidget{

  final String appTitle = "ScrapShare";

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {

  FirebaseFirestore firestore;
  CollectionReference postsRef;

  @override
  void initState() {
    super.initState();
    firestore = FirebaseFirestore.instance;
    postsRef = firestore.collection('posts');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.appTitle,
      theme: ThemeData.light(),
      home: HomePage(
        appTitle: widget.appTitle, 
        postsRef: postsRef
      )
    );
  }



}

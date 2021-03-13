import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/home_appbar.dart';
import '../components/home_floating_action_button.dart';
import '../components/home_stream_builder.dart';

class HomePage extends StatefulWidget{

  static const routeName = "/";

  final String appTitle = "ScrapShare";

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>{

  FirebaseFirestore firestore;
  CollectionReference postsRef;

  @override
  void initState() {
    super.initState();
    firestore = FirebaseFirestore.instance;
    postsRef = firestore.collection('posts');
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: HomeAppBar.getAppBar(widget.appTitle),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: HomeFloatingActionButton(),
      body: HomeStreamBuilder(postsRef: postsRef)
    );
  }

}
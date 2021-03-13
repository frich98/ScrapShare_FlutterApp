import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/home_appbar.dart';
import '../components/home_floating_action_button.dart';
import '../components/home_stream_builder.dart';

class HomePage extends StatefulWidget{

  final String appTitle;
  final CollectionReference postsRef;
  HomePage({this.appTitle, this.postsRef});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: HomeAppBar.getAppBar(widget.appTitle),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: HomeFloatingActionButton(),
      body: HomeStreamBuilder(postsRef: widget.postsRef)
    );
  }

}
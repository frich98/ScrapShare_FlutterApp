import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/widgets/general_appbars.dart';
import '../components/widgets/list_screen_floating_action_button.dart';
import '../components/widgets/list_screen_stream_builder.dart';

class ListScreen extends StatefulWidget{

  static const routeName = "/";

  @override
  ListScreenState createState() => ListScreenState();
}

class ListScreenState extends State<ListScreen>{

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
      appBar: GeneralAppbars.getAppBarBasic(false),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: ListScreenFloatingActionButton(postsRef: postsRef),
      body: ListScreenStreamBuilder(postsRef: postsRef)
    );
  }

}
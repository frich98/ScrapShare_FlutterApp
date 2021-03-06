import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../functions/format_date.dart';
import '../../models/post.dart';
import '../../screens/detail_screen.dart';

class ListScreenStreamBuilder extends StatefulWidget{

  final CollectionReference postsRef;
  ListScreenStreamBuilder({this.postsRef});

  @override
  ListScreenStreamBuilderState createState() => ListScreenStreamBuilderState(); 
}

class ListScreenStreamBuilderState extends State<ListScreenStreamBuilder>{

  @override
  Widget build(BuildContext context){
    return StreamBuilder(
      stream: widget.postsRef.orderBy("date", descending: true).snapshots(),
      builder: (context, snapshot) {
        if(_hasData(snapshot)){
          return _listViewBuilder(snapshot);
        }
          return _noDataDisplay(context);
        }
    );
  }

  Widget _noDataDisplay(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(child: CircularProgressIndicator())
          ]
        )
      ]
    );
  }

  Widget _listViewBuilder(AsyncSnapshot snapshot){
    return ListView.builder(
      itemCount: snapshot.data.docs.length,
      itemBuilder: (context, index) {
        Post post =  _createPost(snapshot, index);
        return _getTile(post);
      }  
    );
  }

  Post _createPost(AsyncSnapshot snapshot, int index){
    Post post = Post(
      date: snapshot.data.docs[index]['date'].toDate(),
      imageURL: snapshot.data.docs[index]['imageURL'],
      quantity: int.parse(snapshot.data.docs[index]['quantity'].toString()),
      latitude: double.parse(snapshot.data.docs[index]['latitude'].toString()),
      longitude: double.parse(snapshot.data.docs[index]['longitude'].toString())
    );
    return post;
  }
  
  bool _hasData(AsyncSnapshot snapshot){
    return snapshot.hasData && snapshot.data.documents != null && snapshot.data.documents.length > 0;
  }

  Widget _getTile(Post post){

    DateTime date = post.date;
    String quantity = post.quantity.toString();

    return Semantics(
      label: 'Post summary, displayed in a list of other posts',
      hint: 'Tap to view the details of the post',
      enabled: true,     
      child: ListTile(
      onTap: () => _goToDetailScreen(context, post),
      title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(formatDate(date)),
        Text(quantity)
      ])
    )
    );

  }

  void _goToDetailScreen(BuildContext context, Post post){
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => DetailScreen(post: post))
    );
  }
}
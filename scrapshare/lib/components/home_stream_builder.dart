import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeStreamBuilder extends StatefulWidget{

  final CollectionReference postsRef;
  HomeStreamBuilder({this.postsRef});

  @override
  HomeStreamBuilderState createState() => HomeStreamBuilderState(); 
}

class HomeStreamBuilderState extends State<HomeStreamBuilder>{

  @override
  Widget build(BuildContext context){
    return StreamBuilder(
      stream: widget.postsRef.orderBy("date", descending: true).snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasData && snapshot.data.documents != null && snapshot.data.documents.length > 0) {
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              return _getTile(snapshot.data.docs[index]['date'].toDate(), 
                              snapshot.data.docs[index]['quantity'].toString());
            }  
          );
        } else {
          return CircularProgressIndicator();
        }
      }
    );
  }

  Widget _getTile(DateTime date, String quantity){
    return ListTile(
      title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(DateFormat('EEEE, MMMM d, yyyy').format(date)),
        Text(quantity)
      ])
    );
  }



}
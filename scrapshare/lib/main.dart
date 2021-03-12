import "dart:io";
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatefulWidget{
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
    //posts = postsCollection.orderBy("date", descending: false);
  }

  Future<void> addPost(){
    return postsRef.add({
      'date': DateTime.now(),
      'imageURL': 'test.com',
      'quantity': 5,
      'latitude': 25,
      'longitude': 125
    })
    .then( (value) => print("Post Added"))
    .catchError( (error) => print("Failed to add post: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ScrapShare',
      theme: ThemeData.light(),
      home: homePage(context)
    );
  }

  Widget homePage(BuildContext context){


    return Scaffold(
      appBar: AppBar(
        title: Text("ScrapShare"),
        centerTitle: true,
        backgroundColor: Colors.purple[300]
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: Semantics(
        label: 'New Post Button',
        hint: 'Press to create a new post',
        enabled: true,
        button: true,
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
          backgroundColor: Colors.purple[700],
        )
      ),
      body:StreamBuilder(
        stream: postsRef.orderBy("date", descending: true).snapshots(),
        builder: (context, snapshot){
          if(snapshot.hasData && snapshot.data.documents != null && snapshot.data.documents.length > 0) {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(DateFormat('EEEE, MMMM d, yyyy').format(snapshot.data.docs[index]['date'].toDate())),
                      Text(snapshot.data.docs[index]['quantity'].toString())
                  ])
                );
              }  
            );
          } else {
            return CircularProgressIndicator();
          }
        }
      )
    );
  }

  /*Widget homePage(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("ScrapShare")),
      body: Column(children: [Text("Hi!")]),
      floatingActionButton: FloatingActionButton(
        onPressed: addPost,
        child: Text("Add Post")
      ),
    );
  }*/


}

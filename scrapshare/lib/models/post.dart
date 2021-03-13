import 'package:cloud_firestore/cloud_firestore.dart';

class Post {

  DateTime date;
  String imageURL;
  int quantity;
  double latitude;
  double longitude;

  CollectionReference postsRef;

  Post({this.date, this.imageURL, this.quantity, this.latitude, this.longitude,
        this.postsRef
  });
  
  Future<void> addPost(){
    return postsRef.add({
      'date': date,
      'imageURL': imageURL,
      'quantity': quantity,
      'latitude': latitude,
      'longitude': longitude
    })
    .then( (value) => print("Post Added"))
    .catchError( (error) => print("Failed to add post: $error"));
  }

}
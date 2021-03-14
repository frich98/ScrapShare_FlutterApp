import 'package:flutter/material.dart';

class NewPostImageNotNull extends StatelessWidget{

  final String imageURL;
  NewPostImageNotNull({this.imageURL});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.purple[500])),
          child: Image.network(imageURL, height: 250, width: 350)),
      ]
    );
  }
  
}
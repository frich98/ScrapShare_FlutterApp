import 'package:flutter/material.dart';

class NewPostImageNull extends StatelessWidget{
  @override
  Widget build(BuildContext context)  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Text("Loading image...", style: TextStyle(fontSize: 35, color: Colors.purple[600]))),
        SizedBox(height: 20),
        CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.purple[600]))    
      ]
    );
  }
}
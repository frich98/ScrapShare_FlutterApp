import 'package:flutter/material.dart';

import '../screens/photo_screen.dart';

class ListScreenFloatingActionButton extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Semantics(
      label: 'New Post Button',
      hint: 'Press to create a new post',
      enabled: true,
      button: true,
      child: _floatingActionButton(context)
    );
  }

  Widget _floatingActionButton(BuildContext context){
    return FloatingActionButton(
      onPressed: () => _goToPhotoScreen(context),
      child: Icon(Icons.add),
      backgroundColor: Colors.purple[700],
    );
  }

    void _goToPhotoScreen(BuildContext context){
    Navigator.push(context, 
      MaterialPageRoute(builder: (context) => PhotoScreen())
    );
  }

}
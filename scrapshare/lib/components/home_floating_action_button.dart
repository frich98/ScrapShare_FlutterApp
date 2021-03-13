import 'package:flutter/material.dart';

class HomeFloatingActionButton extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Semantics(
      label: 'New Post Button',
      hint: 'Press to create a new post',
      enabled: true,
      button: true,
      child: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Colors.purple[700],
      )
    );
  }
}
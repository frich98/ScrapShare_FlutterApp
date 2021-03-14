import 'package:flutter/material.dart';

class NewPostSaveButton extends StatelessWidget{

  final Function saveOnPressed;
  NewPostSaveButton({this.saveOnPressed});

  @override
  Widget build(BuildContext context){
    
    return Container(
      width: 350, height: 50,
      child: Semantics( 
        label: 'Save New Post',
        hint: 'Press to save your new post',
        enabled: true,
        button: true,            
        child: ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.purple[500])),
          onPressed: () => saveOnPressed(),
          child: Text("Upload Post!", style: TextStyle(fontSize: 30)
        )
      ))
    );
  }




}
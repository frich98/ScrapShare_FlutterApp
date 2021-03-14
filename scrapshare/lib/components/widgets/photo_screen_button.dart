import 'package:flutter/material.dart';

class PhotoScreenButton extends StatelessWidget{

  final Function(BuildContext) getImageForPost;
  PhotoScreenButton({this.getImageForPost});

  @override
  Widget build(BuildContext context){
    return Row(        
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
            height: 100, width: 300,
            child: _button(context)
          )
        )
    ]);
  }

  Widget _button(BuildContext context){
    return Semantics(
      label: 'Choose a photo from your photo gallery which will direct you to create a new post with it',
      hint: 'Press to choose a photo from your gallery for your new post',
      enabled: true,
      button: true,
      child: ElevatedButton(
        style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.purple[100])
      ),
      child: _buttonText(context),
      onPressed: () =>  getImageForPost(context)
    )
    );
  }

  Widget _buttonText(BuildContext context){
    return Text(
      "Get Photo From Gallery", 
      style: TextStyle(
        fontSize: 25,
        color: Colors.purple[600]
      )
    );
  }



}
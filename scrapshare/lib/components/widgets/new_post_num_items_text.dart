import 'package:flutter/material.dart';

class NewPostNumItemsText extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Center(
      child: Text("Number of Items: ",
      style: TextStyle(
        fontSize: 25,
        fontStyle: FontStyle.italic,
        color: Colors.grey[600])
      )
    );
  }

}


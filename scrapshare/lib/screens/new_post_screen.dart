import 'package:flutter/material.dart';

import '../components/general_appbar.dart';

class NewPostScreen extends StatefulWidget{

  static const routeName = "newpostscreen";

  final String imageURL;
  NewPostScreen({this.imageURL});

  @override
  NewPostScreenState createState() => NewPostScreenState();
}

class NewPostScreenState extends State<NewPostScreen>{

  final formKey = GlobalKey<FormState>();

  FocusNode quantityFocusNode;

  @override
  void initState(){
    super.initState();
    quantityFocusNode = FocusNode();
  }

  @override
  void dispose() {
    quantityFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: GeneralAppBar.getAppBar(),
      body: Container( 
        //alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        child: ListView(        
        children: [
          Row(children: [SizedBox(height: 20)]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.purple[500])),
                child: Image.network(widget.imageURL, height: 250, width: 350)),
            ]
          ),              
        SizedBox(height: 20),
        Center(child: Text("Number of Items: ", style: TextStyle(fontSize: 25))),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center, 
          children:[ _quantityFormField(context)]
        ),
        SizedBox(height: 40),
        Container(
          width: 350, height: 50,
          child: ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.purple[500])),
          onPressed: () {},
          child: Text("Upload Post!", 
          style: TextStyle(fontSize: 30)
          )
        )
        )
      ])
    )
    );
  }

 Widget _quantityFormField(BuildContext context){
    return Container(
      width: 200, height: 100,
      child: TextFormField(
        focusNode: quantityFocusNode,
        decoration: titleDecoration(),
        validator: (value) => _validateText(value),
        onTap: () => quantityFocusNode.requestFocus(),
        onSaved: (value) {},
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 25),
        keyboardType: TextInputType.number
      )
    );    
  }

  String _validateText(String quantity){
    return null;
  }

  InputDecoration titleDecoration(){
    return InputDecoration(
      labelText: '',
      labelStyle: TextStyle(
        color: Colors.grey,
      ),
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.purple[300])
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.teal[300])
      ),
      contentPadding: new EdgeInsets.symmetric(vertical: 10, horizontal: 10)
    );
  }

}
import 'package:flutter/material.dart';
import 'package:scrapshare/functions/validate_nonempty_text.dart';

import '../../functions/validate_nonempty_text.dart';

class NewPostQuantityFormField extends StatefulWidget{

  final Key formKey;
  final FocusNode focusNode;
  final Function(int) setQuantity;

  NewPostQuantityFormField(
    this.formKey, this.focusNode,
    this.setQuantity
  );

  @override
  NewPostQuantityFormFieldState createState() => NewPostQuantityFormFieldState();
}

class NewPostQuantityFormFieldState extends State<NewPostQuantityFormField>{

  @override
  Widget build(BuildContext context){
    return _quantityFormFieldRow(context);
  }

  Widget _quantityFormFieldRow(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, 
      children: [
        _quantityFormField(context)
      ]
    );
  }

 Widget _quantityFormField(BuildContext context){
    return Semantics(
      label: 'Scrap quantity form field',
      hint: 'Tap to enter the quantity of scrap items, the numerpad will appear when tapped',
      enabled: true,
      textField: true,      
      child: Container(
      width: 200, height: 100,
      child: Form(
        key: widget.formKey,
        child: TextFormField(
          focusNode: widget.focusNode,
          decoration: titleDecoration(),
          validator: (value) => validateText(value),
          onTap: () => widget.focusNode.requestFocus(),
          onSaved: (value) => widget.setQuantity(int.parse(value)),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25),
          keyboardType: TextInputType.number
        )
      )
    )
    );    
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
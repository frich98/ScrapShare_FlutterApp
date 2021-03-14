import 'dart:io';
import 'package:flutter/material.dart';

import '../image/image_getter.dart';

import 'new_post_num_items_text.dart';
import 'new_post_quantity_form_field.dart';
import 'new_post_save_button.dart';

class NewPostListView extends StatelessWidget{

  final Function(String) setImageURL;
  final String imageURL;
  final File imageFile;
  final GlobalKey<FormState> formKey;
  final FocusNode focusNode;
  final Function(int) setQuantity;
  final Function saveOnPressed;

  NewPostListView({
    this.imageURL,
    this.setImageURL, this.imageFile,
    this.formKey, this.focusNode,
    this.setQuantity, this.saveOnPressed
  });

  @override
  Widget build(BuildContext context){
    return  ListView(
      children: [
        SizedBox(height: 20),
        ImageGetter(setImageURL: setImageURL, imageFile: imageFile),
        SizedBox(height: 20),
        NewPostNumItemsText(),
        SizedBox(height: 20),
        NewPostQuantityFormField(formKey, focusNode, setQuantity),
        SizedBox(height: 40),
        NewPostSaveButton(saveOnPressed: saveOnPressed)
      ]
    );
  }
}


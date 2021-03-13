import 'package:flutter/material.dart';

class GeneralAppBar {
  static getAppBar(bool implyLeading){
    return AppBar(
        automaticallyImplyLeading: implyLeading,
        title: Text("ScrapShare"),
        centerTitle: true,
        backgroundColor: Colors.purple[300]
    );
  }

}
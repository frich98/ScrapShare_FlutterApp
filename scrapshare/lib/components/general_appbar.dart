import 'package:flutter/material.dart';

class GeneralAppBar {
  static getAppBar(){
    return AppBar(
        title: Text("ScrapShare"),
        centerTitle: true,
        backgroundColor: Colors.purple[300]
    );
  }
}
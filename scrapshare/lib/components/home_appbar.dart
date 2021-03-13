
import 'package:flutter/material.dart';

class HomeAppBar {
  static getAppBar(String appTitle){
    return AppBar(
        title: Text(appTitle),
        centerTitle: true,
        backgroundColor: Colors.purple[300]
    );
  }
}
import 'package:flutter/material.dart';

class GeneralAppbars{

  static getAppBarBasic(bool implyLeading){
    return AppBar(
        automaticallyImplyLeading: implyLeading,
        title: Text("ScrapShare"),
        centerTitle: true,
        backgroundColor: Colors.purple[300]
    );
  }

  static getAppBarIfImageNull(Function(BuildContext) onPressedAction){
        return AppBar(
          leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => onPressedAction(context),
           );
         }
        ),
        title: Text("ScrapShare"),
        centerTitle: true,
        backgroundColor: Colors.purple[300],
      );
  }

  static getAppBarIfImage(Function(BuildContext) onPressedAction){
        return AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => onPressedAction(context),
           );
         }
        ),
        title: Text("ScrapShare"),
        centerTitle: true,
        backgroundColor: Colors.purple[300],
      );
  }


}
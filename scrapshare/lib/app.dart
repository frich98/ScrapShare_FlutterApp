import 'package:flutter/material.dart';

import 'screens/detail_screen.dart';
import 'screens/list_screen.dart';
import 'screens/new_post_screen.dart';
import 'screens/photo_screen.dart';

class App extends StatefulWidget{

  final String appTitle = "ScrapShare";

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {

  static final routes = {
    ListScreen.routeName: (context) => ListScreen(),
    DetailScreen.routeName: (context) => DetailScreen(),
    NewPostScreen.routeName: (context) => NewPostScreen(),
    PhotoScreen.routeName: (context) => PhotoScreen()
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.appTitle,
      theme: ThemeData.light(),
      routes: routes,
      initialRoute: ListScreen.routeName,
    );
  }

}

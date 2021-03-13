import 'package:flutter/material.dart';

import './screens/homepage_screen.dart';

class App extends StatefulWidget{

  final String appTitle = "ScrapShare";

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {

  static final routes = {
    HomePage.routeName: (context) => HomePage()
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.appTitle,
      theme: ThemeData.light(),
      routes: routes,
      initialRoute: HomePage.routeName,
    );
  }



}

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:list_pessoas/controllers/users_controller.dart';
import 'package:list_pessoas/ui/list_users.dart';
import 'package:list_pessoas/ui/register_user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'list pessoas',
      theme: ThemeData(
        brightness: Brightness.dark,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                textStyle: MaterialStateProperty.all(TextStyle(color: Colors.black87)), backgroundColor: MaterialStateProperty.all(Color(0xff64ffda)))),
        buttonTheme: ButtonThemeData(buttonColor: Color(0xff64ffda), textTheme: ButtonTextTheme.primary),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.white54),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white54, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white54, width: 1.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white54, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white54, width: 1.0),
          ),
        ),
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
          headline6: TextStyle(fontSize: 24.0, fontStyle: FontStyle.normal, fontFamily: 'Roboto'),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: ListPage(),
    );
  }
}

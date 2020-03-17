import 'package:flutter/material.dart';
import 'package:flutterfirebase/models/user.dart';
import 'package:flutterfirebase/screen/wrapper.dart';
import 'package:flutterfirebase/services/auth.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value( // all the childs provider can access the value
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
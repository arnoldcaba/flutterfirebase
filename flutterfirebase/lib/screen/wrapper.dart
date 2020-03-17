import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/models/user.dart';
import 'package:flutterfirebase/screen/authenticate/authenticate.dart';
import 'package:flutterfirebase/screen/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    // retunr auth or home
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
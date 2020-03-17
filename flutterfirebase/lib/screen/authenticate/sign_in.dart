import 'package:flutter/material.dart';
import 'package:flutterfirebase/services/auth.dart';
import 'package:flutterfirebase/shared/constants.dart';
import 'package:flutterfirebase/shared/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _fomrKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('sign in to Brew Crew'),
        actions: <Widget>[
          FlatButton.icon(onPressed: () { widget.toggleView(); }, icon: Icon(Icons.person), label: Text('Register'))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _fomrKey,
          child: Column(children: <Widget>[
            SizedBox(height: 20.0,),
            TextFormField(
              decoration: personalDecoration.copyWith(hintText: 'Email *', icon: Icon(Icons.person)),
              onChanged: (val) {
                setState(() {
                  email = val;
                });
              },
              validator: (val) => val.isEmpty ? 'Enter an email' : null,
            ),
            SizedBox(height: 20.0,),
            TextFormField(
              decoration: personalDecoration.copyWith(hintText: 'Password *', icon: Icon(Icons.lock_outline)),
              obscureText: true,
              onChanged: (val) {
                setState(() {
                  password = val;
                });
              },
              validator: (val) => val.length <= 5 ? 'password must be greater than 6 chars' : null,
            ),
            SizedBox(height: 20.0,),
            RaisedButton(
              onPressed: () async {
                if (_fomrKey.currentState.validate()) { // true or false
                  setState(() {
                    loading = true;
                  });
                  dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                  if (result == null) {
                    setState(() {
                      error = 'Error de autenticación';
                      loading = false;
                    });
                  }
                }
              },
              color: Colors.pink[400],
              child: Text('Sign_in', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 12.0),
            Text(
              error,
              style: TextStyle(color: Colors.red, fontSize: 14.0),
            )
          ],),
        ),
      )
    );
  }
}
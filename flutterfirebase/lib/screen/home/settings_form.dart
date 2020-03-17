import 'package:flutter/material.dart';
import 'package:flutterfirebase/models/user.dart';
import 'package:flutterfirebase/services/database.dart';
import 'package:flutterfirebase/shared/constants.dart';
import 'package:flutterfirebase/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];
  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Update your brew settings',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: userData.name,
                  decoration: personalDecoration.copyWith(hintText: 'Name *', icon: Icon(Icons.person)),
                  onChanged: (val) {
                    setState(() {
                      _currentName = val;
                    });
                  },
                  validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                ),
                SizedBox(height: 20.0),
                DropdownButtonFormField(
                  decoration: personalDecoration,
                  value: _currentSugars ?? userData.sugars,
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(value: sugar, child: Text('$sugar sugars'));
                  }).toList(),
                  onChanged: (String value) {
                    print('in current sugar value');
                    setState(() {
                      _currentSugars = value;
                    });
                  },
                ),
                SizedBox(height: 10.0),
                Slider(
                  activeColor: Colors.brown[_currentStrength ?? 100],
                  inactiveColor: Colors.brown,
                  min: 100.0,
                  max: 900.0,
                  divisions: 8,
                  onChanged: (val) {
                    setState(() {
                      _currentStrength = val.round();
                    });
                  },
                  value: (_currentStrength ?? userData.strength).toDouble(),
                ),
                SizedBox(height: 10.0),
                RaisedButton(
                  onPressed: () async {
                    if(_formKey.currentState.validate()) {
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentSugars ?? userData.sugars,
                        _currentName ?? userData.name,
                        _currentStrength ?? userData.strength);
                       Navigator.pop(context);
                    }
                  },
                  color: Colors.pink[400],
                  child: Text('Update', style: TextStyle(color: Colors.white))
                )
              ],
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
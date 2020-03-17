import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfirebase/models/brew.dart';
import 'package:flutterfirebase/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference brewCollection = Firestore.instance.collection('brews');
  
  Future updateUserData (String sugars, String name, int strength) async {
    return await brewCollection.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }
  // brew list from snapshot
  List<Brew> _brewListFromSnapShot (QuerySnapshot snapshot) {
    return snapshot.documents.map((snap) {
      return Brew(name: snap.data['name'] ?? '', sugars: snap.data['sugars'] ?? '', strength: snap.data['strength'] ?? 0);
    }).toList();
  }

  // get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapShot);
  }

  // user data from snapshot
  UserData _userDataFromSnapShot (DocumentSnapshot snapshot) {
    return UserData(uid: uid, name: snapshot.data['name'], sugars: snapshot.data['sugars'], strength: snapshot.data['strength']);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return brewCollection.document(uid).snapshots().map(_userDataFromSnapShot);
  }

}
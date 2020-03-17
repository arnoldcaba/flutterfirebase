import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfirebase/models/brew.dart';
import 'package:provider/provider.dart';

import 'brew_tile.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {

    final brews = Provider.of<List<Brew>>(context) ?? [];
    // print(brews);
    /* brews.forEach((brew) {
      print(brew.sugars);
      print(brew.name);
      print(brew.strength);
    }); */

    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (contex, index) {
        return BrewTile(brew: brews[index]);
      },
    );
  }
}
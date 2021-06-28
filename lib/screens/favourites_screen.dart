import 'dart:convert';

import 'package:EasyEat/screens/constants.dart';
import 'package:EasyEat/screens/shared_preferences.dart';
import 'package:EasyEat/screens/top_bar.dart';
import 'package:flutter/material.dart';

class FavouritePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FavouritePageState();

  FavouritePage();
}

class _FavouritePageState extends State<FavouritePage> {
  LocalStorage storage;

  @override
  void initState() {
    initial();
    super.initState();
  }

  void initial() async {
    storage = LocalStorage();
  }

  Future<List<Widget>> getAllPrefs() async {
    return storage
        .getAllKeys()
        .map<Widget>((key) => Card(
                child: ListTile(
              leading:
                  Image.network(json.decode(storage.getByKey(key))["imgURL"]),
              title:
                  Text(json.decode(storage.getByKey(key))["title"].toString(),
                      style: EasyEatTextStyle(
                        fontSize: 22,
                        textColor: EasyEatColors.darkGreen,
                      ).style()),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                color: EasyEatColors.grey,
                onPressed: () {
                  setState(() {
                    storage.removeRecipe(key);
                  });
                },
              ),
              onTap: () {
                print("TAPPED");
              },
            )))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar().build(context),
      body: FutureBuilder<List<Widget>>(
          future: getAllPrefs(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Container();
            return ListView(
              children: snapshot.data,
            );
          }),
    );
  }
}

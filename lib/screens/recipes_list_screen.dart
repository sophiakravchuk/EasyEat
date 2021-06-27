import 'dart:convert';

import 'package:EasyEat/screens/constants.dart';
import 'package:EasyEat/screens/shared_preferences.dart';
import 'package:EasyEat/screens/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RecipesPage extends StatefulWidget {
  @override
  _RecipesPageState createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  List _items = [];
  List<Color> _colors = [];

  LocalStorage storage;

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/example.json');
    final data = await json.decode(response);
    setState(() {
      _items = data;
      _colors = List.filled(_items.length, EasyEatColors.grey);
    });
  }

  @override
  void initState() {
    super.initState();
    this.readJson();
    initial();
  }

  void initial() async {
    storage = LocalStorage();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: TopBar().build(context),
      body: new ListView.builder(
        itemCount: _items == null ? 0 : _items.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              child: Column(children: <Widget>[
            ListTile(
                leading: Image.network(_items[index]["image"]),
                title: Text(_items[index]["title"]),
                subtitle: Text(_items[index]["title"]),
                trailing: IconButton(
                  icon: Icon(Icons.favorite),
                  color: _colors[index],
                  onPressed: () {
                    setState(() {
                      if (_colors[index] == EasyEatColors.grey) {
                        _colors[index] = EasyEatColors.orange;
                        storage.setRecipe(_items[index]["id"].toString(),
                            json.encode(_items[index]));

                        print(_items[index]["id"].toString());
                      } else {
                        _colors[index] = EasyEatColors.grey;
                        storage.removeRecipe(_items[index]["id"].toString());
                      }
                    });
                    print("Favorite");
                    print(_items[index]["title"]);
                  },
                ),
                onTap: () {
                  print("TAPPED");
                }),
          ]));
        },
      ),
    );
  }
}

import 'dart:convert';

import 'package:EasyEat/screens/constants.dart';
import 'package:EasyEat/screens/recipe_screen.dart';
import 'package:EasyEat/screens/shared_preferences.dart';
import 'package:EasyEat/screens/top_bar.dart';
import 'package:EasyEat/services/api_services.dart';
import 'package:EasyEat/services/meal_model.dart';
import 'package:EasyEat/services/recipe_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RecipesPage extends StatefulWidget {
  final List<Meal> meals;

  RecipesPage({Key key, this.meals}) : super(key: key);

  @override
  _RecipesPageState createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  List _items = [];
  List<Color> _colors = [];

  LocalStorage storage;

  // Fetch content from the json file
  // Future<void> readJson() async {
  //   final String response = await rootBundle.loadString('assets/example.json');
  //   final data = await json.decode(response);
  //   setState(() {
  //     _items = data;
  //     _colors = List.filled(_items.length, EasyEatColors.grey);
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // this.readJson();
    this.listIngr();
    initial();
  }

  // Fetch content from the json file
  Future<void> listIngr() async {
    setState(() {
      _items = widget.meals;
      _colors = List.filled(_items.length, EasyEatColors.grey);
    });
  }

  void initial() async {
    storage = LocalStorage();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: TopBar().build(context),
      body: new ListView.builder(
        itemCount: _items.length,
        itemBuilder: (_, int index) {
          return Card(
              child: Column(children: <Widget>[
                ListTile(
                    leading: Image.network(_items[index].imgURL),
                    title: Text(_items[index].title,
                        style: EasyEatTextStyle(
                          fontSize: 20,
                          textColor: EasyEatColors.darkGreen,
                        ).style()),
                    trailing: IconButton(
                      icon: Icon(Icons.favorite),
                      color: _items[index].isFavourite
                          ? EasyEatColors.orange
                          : EasyEatColors.grey,
                      onPressed: () {
                        setState(() {
                          _items[index].isFavourite =
                          !_items[index].isFavourite;
                          if (_items[index].isFavourite) {
                            storage.setRecipe(_items[index].id.toString(),
                                jsonEncode(_items[index].toJson()));
                          } else {
                            storage.removeRecipe(_items[index].id.toString());
                          }
                        });
                      },
                    ),
                    onTap: () async {
                      RecipeInstructions instructions = await _getInstructions(
                          index);

                      Navigator.of(context).push(MaterialPageRoute(
                        builder:
                            (context) =>
                            RecipePage(_items[index], instructions),
                      ),
                      ).then((_) {
                        setState(() {});
                      });
                    }),
              ]));
        },
      ),
    );
  }

  Future<RecipeInstructions> _getInstructions(int index) async {
    RecipeInstructions recipeInstructions = await ApiService.instance.getRecipeSteps(_items[index].id.toString());
    return recipeInstructions;
  }

}

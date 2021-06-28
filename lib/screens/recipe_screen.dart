import 'dart:convert';

import 'package:EasyEat/screens/constants.dart';
import 'package:EasyEat/screens/shared_preferences.dart';
import 'package:EasyEat/screens/top_bar.dart';
import 'package:flutter/material.dart';

class RecipePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RecipePageState();
  RecipePage();
}

class _RecipePageState extends State<RecipePage> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar().build(context),
      body: ListView(
          children: <Widget>[
            Container(
              child: Card(
                // shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: InkWell(
                  // onTap: () => print("ciao"),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,  // add this
                    children: <Widget>[
                      ClipRRect(
                        child: Image.network(
                            'https://spoonacular.com/recipeImages/660261-556x370.jpg',
                            // width: 300,
                            height: 150,
                            fit:BoxFit.fill
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          _topText(context)
          ]
      ),
    );
  }

  Widget _topText(BuildContext context) =>
      Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(4, 2, 18, 18),
              child: Container(
                child: Text(
                "Name of the meal",
                style: EasyEatTextStyle(
                fontSize: 24,
                textColor: EasyEatColors.black,
                ).style(),
                ),
            ),
          ),
        ],
      );


  Widget _topImage(BuildContext context) =>
      Row(
        children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,  // add this
              children: <Widget>[
                ClipRRect(
                  child: Image.network(
                      "https://spoonacular.com/recipeImages/660261-556x370.jpg",
                      // width: 300,
                      height: 150,
                      fit:BoxFit.fill

                  ),
                ),
                ListTile(
                  title: Text('Pub 1'),
                  subtitle: Text('Location 1'),
                ),
              ],
            ),
          ),
          ]
      );

}

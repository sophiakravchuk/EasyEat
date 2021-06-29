import 'dart:convert';

import 'package:EasyEat/screens/constants.dart';
import 'package:EasyEat/screens/shared_preferences.dart';
import 'package:EasyEat/screens/top_bar.dart';
import 'package:EasyEat/services/meal_model.dart';
import 'package:EasyEat/services/recipe_parser.dart';
import 'package:flutter/material.dart';

class RecipePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RecipePageState();
  Meal meal;
  RecipeInstructions instructions;
  RecipePage(this.meal, this.instructions);
}

class _RecipePageState extends State<RecipePage> {

  LocalStorage storage;

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    storage = LocalStorage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar().build(context),
      body: ListView(
          children: <Widget>[
            _topImage(context),
            SizedBox(
              height: 20,
            ),
            _topText(context),
            SizedBox(
              height: 20,
            ),
            _instructionsText(context),
            SizedBox(
              height: 20,
            ),
            _recipeText(context),
            SizedBox(
              height: 30,
            ),
          ]
      ),
    );
  }

  Widget _likeButton() =>
      IconButton(
        icon: Icon(Icons.favorite),
        color: widget.meal.isFavourite
            ? EasyEatColors.orange
            : EasyEatColors.grey,
        onPressed: () {
          setState(() {
            widget.meal.isFavourite = !widget.meal.isFavourite;
            if (widget.meal.isFavourite) {
              storage.setRecipe(widget.meal.id.toString(),
                  jsonEncode(widget.meal.toJson()));
            } else {
              storage.removeRecipe(widget.meal.id.toString());
            }
          });
        },
      );


  Widget _topText(BuildContext context) =>
      Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 18, 0),
            child: Container(
              width: 330,
              child: Text(
                widget.meal.title,
                style: EasyEatTextStyle(
                  fontSize: 28,
                  textColor: EasyEatColors.darkGreen,
                ).style(),
              ),
            ),
          ),
        ],
      );


  Widget _instructionsText(BuildContext context) {
    List<Row> list = new List<Row>();
    for (var i = 0; i < widget.instructions.ings.length; i++) {
      String ingredient = widget.instructions.ings[i].amount.toString() + " ";
      if (widget.instructions.ings[i].units != null) {
        ingredient += widget.instructions.ings[i].units  + " ";
      }
      ingredient += widget.instructions.ings[i].name;
      list.add(Row(
          children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Text(
                      ingredient,
                      style: EasyEatTextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        textColor: EasyEatColors.green,
                      ).style(),
                    ),
                  ),
            SizedBox(
              height: 10,
            ),
          ]
      ),
      );
    }
    return new Column(children: list);
  }


  Widget _recipeText(BuildContext context) {
    List<Row> list = new List<Row>();
    for (var i = 0; i < widget.instructions.steps.length; i++) {
      list.add(Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(30, 1, 30, 1),
            child: Container(
              width: 330,
              child: Text(
                widget.instructions.steps[i],
                style: EasyEatTextStyle(
                  fontSize: 19,
                  textColor: EasyEatColors.darkGreen,
                  fontWeight: FontWeight.normal,
                ).style(),
              ),
            ),
          ),
        ],
      ),
      );
    }
    return new Column(children: list);
  }

  Widget _topImage(BuildContext context) =>
      Container(
        height: 150,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: Image.network(
                  widget.meal.imgURL,
                  height: 150,
                  fit: BoxFit.fill
              ).image,
              fit: BoxFit.cover),
        ),
        child:  Container(
          alignment: Alignment(0.9, -0.8),
          child: CircleAvatar(
            radius: 25,
            backgroundColor: EasyEatColors.white,
            child: _likeButton(),
          ),
      ),
      );



}

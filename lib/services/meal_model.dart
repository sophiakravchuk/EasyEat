import 'package:EasyEat/services/recipe_parser.dart';

class Meal {
  final int id;
  final String title, imgURL;
  List<dynamic> ingredients;
  RecipeInstructions stepsRecipe;
  bool isFavourite;

  Meal(
      {this.id,
      this.title,
      this.imgURL,
      this.ingredients,
      this.stepsRecipe,
      this.isFavourite = false});

//This class has an ID which allows us to get the Recipes and other info
//Such as title and Image URL

/*
Factory Constructor Meal.fromMap parses the decoded JSON data to get the
values of the meal, and returns the Meal Object
*/

  factory Meal.fromMap(Map<String, dynamic> map) {
    //Meal object
    return Meal(
      id: map['id'],
      title: map['title'],
      imgURL: map['image'],
    );
  }

  factory Meal.fromMapForPref(Map<String, dynamic> map) {
    //Meal object
    return Meal(
      id: map['id'],
      title: map['title'],
      imgURL: map['image'],
      isFavourite: map['isFavourite'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'image': imgURL,
        'isFavourite': isFavourite,
      };
}

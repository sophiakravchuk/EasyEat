import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'meal_model.dart';

class ApiService {
  ApiService._instantiate();
  static final ApiService instance = ApiService._instantiate();

  final String _baseURL = "https://api.spoonacular.com";
  static const String API_KEY = "457144eca6094d16b3faae224a781520";

  Future<List<Meal>> fetchRecipe(List<String> ingredients, int numbers) async {
    String ingredientsString = ParseIngredients(ingredients);
    String uri = _baseURL + "/recipes/findByIngredients?ingredients=" +
        ingredientsString + "&number=$numbers"+ "&apiKey=$API_KEY";

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try{
      List<Meal> meals = [];
      var response = await http.get(uri, headers: headers);
      var data = json.decode(response.body);
      for(var data_item in data) {
        Meal meal = Meal.fromMap(data_item);
        meals.add(meal);
      }
      return meals;
    }catch (err) {
      throw err.toString();
    }

  }

  String ParseIngredients(List<String> ingredients){
    String finalString = ingredients[0];
    ingredients.removeAt(0);
    for (var ingredient in ingredients){
      finalString += ",+$ingredient";
    }
    return finalString;
  }

}

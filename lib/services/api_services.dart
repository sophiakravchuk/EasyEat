import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'meal_model.dart';
import 'recipe_parser.dart';

class ApiService {
  ApiService._instantiate();
  static final ApiService instance = ApiService._instantiate();

  final String _baseURL = "https://api.spoonacular.com";
  static const String API_KEY = "457144eca6094d16b3faae224a781520";

  Future<List<dynamic>> makeResponse (String parametrsUri) async {
    String uri = _baseURL + parametrsUri + "&apiKey=$API_KEY";

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try{
      var response = await http.get(uri, headers: headers);
      var data = json.decode(response.body);
      if (data is Map<String, dynamic>) {
        List<dynamic> dataList = [];
        dataList.add(data);
        return dataList;
      }

      return data;
    }catch (err) {
      throw err.toString();
    }


  }

  Future<List<Meal>> fetchRecipe(List<String> ingredients, int numbers) async {
    String ingredientsString = _parseIngredients(ingredients);

    String params = "/recipes/findByIngredients?ingredients=" + ingredientsString + "&number=$numbers";

    List<dynamic> dataList = await makeResponse(params);
    List<Meal> meals = [];
    for(var data_item in dataList) {
      Meal meal = Meal.fromMap(data_item);
      meals.add(meal);
    }
    return meals;
  }

  Future<RecipeInstructions> getRecipeSteps(String recipeId) async {

    String params = '/recipes/$recipeId/information?includeNutrition=false';
    List<dynamic> dataList = await makeResponse(params);

    RecipeInstructions recipe = RecipeInstructions();
    recipe = recipe.fromMap(dataList[0]);
    return recipe;
  }


  String _parseIngredients(List<String> ingredients){
    String finalString = ingredients[0];
    ingredients.removeAt(0);
    for (var ingredient in ingredients){
      finalString += ",+$ingredient";
    }
    return finalString;
  }


}

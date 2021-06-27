class Recipe {
  final String spoonacularSourceUrl;

  //has Equipment, Ingredients, Steps, e.t.c

  Recipe({this.spoonacularSourceUrl,});

//The spoonacularSourceURL displays the meals recipe in our webview

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      spoonacularSourceUrl: map['spoonacularSourceUrl'],
    );
  }
}
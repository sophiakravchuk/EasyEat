import 'ingredient.dart';

class RecipeInstructions {
  final List<Ingredient> ings;
  final List<String> steps;

  RecipeInstructions({
    this.ings,
    this.steps
  });

  List<String> _getSteps(Map<String, dynamic> map) {
    List<String> stepsInstr = [];
    if (map['analyzedInstructions'].isNotEmpty) {
      for (var step in map['analyzedInstructions'][0]['steps']) {
        String stepText = step['step'];
        stepsInstr.add(stepText);
      }
    }

    return stepsInstr;
  }

  List<Ingredient> _getIngs(Map<String, dynamic> map) {
    List<Ingredient> ingsList = [];
    if (map['extendedIngredients'].isNotEmpty) {
      for (var ingredient in map['extendedIngredients']) {
        Ingredient ingredientObject = Ingredient.fromMap(ingredient);
        ingsList.add(ingredientObject);
      }
    }

    return ingsList;
  }

  fromMap(Map<String, dynamic> map) {
    return RecipeInstructions(
      ings: _getIngs(map),
      steps: _getSteps(map),
    );
  }
}
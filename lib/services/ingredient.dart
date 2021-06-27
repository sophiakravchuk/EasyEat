class Ingredient {
  final String name, units;
  final double amount;


  Ingredient({
    this.name,
    this.units,
    this.amount
  });

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(
      name: map['name'],
      units: map['units'],
      amount: map['amount'],
    );
  }
}
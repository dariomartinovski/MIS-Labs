import 'package:recipes_app/models/extended_ingredient.dart';

// {
//         "id": 664470,
//         "imageType": "jpg",
//         "title": "Vegan Pea and Mint Pesto Bruschetta",
//         "readyInMinutes": 45,
//         "servings": 10,
//         "sourceUrl": "https://spoonacular.com/vegan-pea-and-mint-pesto-bruschetta-664470"
//     },

class Recipe {
  final int id;
  final String title;
  final String? summary;
  final String? image;
  final int? readyInMinutes;
  final int? servings;
  final double? pricePerServing;
  final List<ExtendedIngredient> extendedIngredients;
  final List<String> dishTypes;
  final List<String> diets;
  final List<String> cuisines;
  final String? instructions;
  final int aggregateLikes;
  final bool vegetarian;
  final bool vegan;
  final bool glutenFree;
  final bool dairyFree;
  final bool veryHealthy;
  final bool cheap;

  Recipe({
    required this.id,
    required this.title,
    this.summary,
    this.image,
    this.readyInMinutes,
    this.servings,
    this.pricePerServing,
    this.extendedIngredients = const [],
    this.dishTypes = const [],
    this.diets = const [],
    this.cuisines = const [],
    this.instructions,
    this.aggregateLikes = 0,
    this.vegetarian = false,
    this.vegan = false,
    this.glutenFree = false,
    this.dairyFree = false,
    this.veryHealthy = false,
    this.cheap = false,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      title: json['title'],
      summary: json['summary'],
      image: json['image'],
      readyInMinutes: json['readyInMinutes'],
      servings: json['servings'],
      pricePerServing: (json['pricePerServing'] as num?)?.toDouble(),
      extendedIngredients: (json['extendedIngredients'] as List)
          .map((e) => ExtendedIngredient.fromJson(e))
          .toList(),
      dishTypes: List<String>.from(json['dishTypes'] ?? []),
      diets: List<String>.from(json['diets'] ?? []),
      cuisines: List<String>.from(json['cuisines'] ?? []),
      instructions: json['instructions'],
      aggregateLikes: json['aggregateLikes'] ?? 0,
      vegetarian: json['vegetarian'] ?? false,
      vegan: json['vegan'] ?? false,
      glutenFree: json['glutenFree'] ?? false,
      dairyFree: json['dairyFree'] ?? false,
      veryHealthy: json['veryHealthy'] ?? false,
      cheap: json['cheap'] ?? false,
    );
  }
}
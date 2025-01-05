import 'dart:async';
import 'package:recipes_app/data/mock_recipes.dart';
import '../models/recipe.dart';

class MockRecipeService {
  Future<List<Recipe>> fetchRandomRecipes(int n, {String? diet}) async {
    await Future.delayed(Duration(seconds: 1));
    return exampleRecipesJson
        .take(n)
        .map((json) => Recipe.fromJson(json)).toList();
  }

  Future<List<Recipe>> fetchBreakfastRecipes(int n) async {
    await Future.delayed(Duration(milliseconds: 200));
    return exampleRecipesJson
        .take(n)
        .map((json) => Recipe.fromJson(json)).toList();
  }

  Future<List<Recipe>> fetchPopularRecipes(int n, {String? diet}) async {
    await Future.delayed(Duration(seconds: 1));
    return exampleRecipesJson
        .take(n.clamp(0, exampleRecipesJson.length))
        .map((json) => Recipe.fromJson(json))
        .toList();
  }

  Future<List<Recipe>> fetchFeaturedRecipes({String? diet}) async {
    await Future.delayed(Duration(seconds: 1));
    return exampleRecipesJson.take(3).map((json) => Recipe.fromJson(json)).toList();
  }

  Future<Recipe> fetchFeaturedRecipe({String? diet}) async {
    await Future.delayed(Duration(seconds: 1));
    var recipeJson = exampleRecipesJson.take(1).first;
    return Recipe.fromJson(recipeJson);
  }

  Future<Map<String, dynamic>> fetchRecipeDetails(int id) async {
    await Future.delayed(Duration(seconds: 1));
    var recipeJson = exampleRecipesJson.firstWhere(
          (json) => json['id'] == id,
      orElse: () => {},
    );

    if (recipeJson.isNotEmpty) {
      var similarRecipes = exampleRecipesJson.where((json) => json['id'] != id).toList();
      return {
        'recipe': Recipe.fromJson(recipeJson),
        'similarRecipes': similarRecipes.map((json) => Recipe.fromJson(json)).toList(),
      };
    } else {
      throw Exception('Recipe not found');
    }
  }

  Future<List<Recipe>> searchRecipes(String query, {String? diet}) async {
    await Future.delayed(Duration(seconds: 1));
    return exampleRecipesJson
        .where((json) => json['title'] != null && json['title'].toLowerCase().contains(query.toLowerCase()))
        .map((json) => Recipe.fromJson(json))
        .toList();
  }

  Future<List<Recipe>> fetchSimilarRecipes(int id) async {
    await Future.delayed(Duration(seconds: 1));
    var similarRecipes = exampleRecipesJson.where((json) => json['id'] != id).toList();
    return similarRecipes.map((json) => Recipe.fromJson(json)).toList();
  }
}
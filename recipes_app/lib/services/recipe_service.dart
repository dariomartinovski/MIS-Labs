import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipes_app/models/recipe.dart';

class RecipeService {
  final String apiKey;

  RecipeService({required this.apiKey});

  final String baseUrl = 'https://api.spoonacular.com/recipes';

  /// Fetches N random recipes.
  Future<List<Recipe>> fetchRandomRecipes(int n, {String? diet}) async {
    final dietQuery = diet != null ? '&diet=$diet' : '';
    final url = Uri.parse('$baseUrl/random?apiKey=$apiKey&number=$n$dietQuery');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['recipes'] as List).map((json) => Recipe.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch random recipes');
    }
  }

  /// Fetches N random popular recipes.
  Future<List<Recipe>> fetchPopularRecipes(int n, {String? diet}) async {
    final dietQuery = diet != null ? '&diet=$diet' : '';
    final url = Uri.parse('$baseUrl/random?apiKey=$apiKey&number=$n&sort=popularity$dietQuery');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['recipes'] as List).map((json) => Recipe.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch popular recipes');
    }
  }

  /// Fetches featured recipes (you can adjust the number of recipes fetched).
  Future<List<Recipe>> fetchFeaturedRecipes({String? diet}) async {
    final dietQuery = diet != null ? '&diet=$diet' : '';
    final url = Uri.parse('$baseUrl/random?apiKey=$apiKey&number=3&sort=popularity&type=main course$dietQuery');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['recipes'] as List).map((json) => Recipe.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch featured recipes');
    }
  }

  /// Fetches the details of a recipe by its ID, including similar recipes.
  Future<Map<String, dynamic>> fetchRecipeDetails(int id) async {
    final detailsUrl = Uri.parse('$baseUrl/$id/information?apiKey=$apiKey');
    final similarUrl = Uri.parse('$baseUrl/$id/similar?apiKey=$apiKey');

    final detailsResponse = await http.get(detailsUrl);
    final similarResponse = await http.get(similarUrl);

    if (detailsResponse.statusCode == 200 && similarResponse.statusCode == 200) {
      final detailsData = jsonDecode(detailsResponse.body);
      final similarData = jsonDecode(similarResponse.body);
      return {
        'recipe': Recipe.fromJson(detailsData),
        'similarRecipes': (similarData as List).map((json) => Recipe.fromJson(json)).toList(),
      };
    } else {
      throw Exception('Failed to fetch recipe details or similar recipes');
    }
  }

  /// Fetches N breakfast recipes.
  Future<List<Recipe>> fetchBreakfastRecipes(int n, {String? diet}) async {
    final dietQuery = diet != null ? '&diet=$diet' : '';
    final url = Uri.parse('$baseUrl/complexSearch?apiKey=$apiKey&number=$n&mealType=breakfast$dietQuery');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['results'] as List).map((json) => Recipe.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch breakfast recipes');
    }
  }

  /// Searches for recipes based on a query.
  Future<List<Recipe>> searchRecipes(String query) async {
    final url = Uri.parse('$baseUrl/complexSearch?apiKey=$apiKey&query=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['results'] as List).map((json) => Recipe.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search recipes for query "$query"');
    }
  }

  Future<List<Recipe>> fetchFullRecipesForSearch(String query) async {
    final searchUrl = Uri.parse('$baseUrl/complexSearch?apiKey=$apiKey&query=$query');
    final searchResponse = await http.get(searchUrl);

    if (searchResponse.statusCode != 200) {
      throw Exception('Failed to search recipes for query "$query"');
    }

    final searchData = jsonDecode(searchResponse.body);
    final searchResults = searchData['results'] as List;

    final requests = searchResults.map((recipe) {
      final recipeId = recipe['id'];
      final fullRecipeUrl = Uri.parse(
          'https://api.spoonacular.com/recipes/$recipeId/information?apiKey=$apiKey');
      return http.get(fullRecipeUrl);
    }).toList();

    final responses = await Future.wait(requests);

    return responses
        .where((response) => response.statusCode == 200)
        .map((response) => Recipe.fromJson(jsonDecode(response.body)))
        .toList();
  }


  /// Fetches recipes similar to a given recipe ID.
  Future<List<Recipe>> fetchSimilarRecipes(int id) async {
    final url = Uri.parse('$baseUrl/$id/similar?apiKey=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data as List).map((json) => Recipe.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch similar recipes for ID $id');
    }
  }

  Future<List<Recipe>> fetchFullRecipesForSimilar(int recipeId) async {
    final similarRecipesUrl =
        'https://api.spoonacular.com/recipes/$recipeId/similar?apiKey=$apiKey';

    final similarResponse = await http.get(Uri.parse(similarRecipesUrl));
    if (similarResponse.statusCode != 200) {
      throw Exception('Failed to fetch similar recipes');
    }

    final similarRecipes = jsonDecode(similarResponse.body) as List;

    final requests = similarRecipes.map((recipe) {
      final recipeId = recipe['id'];
      final fullRecipeUrl =
          'https://api.spoonacular.com/recipes/$recipeId/information?apiKey=$apiKey';
      return http.get(Uri.parse(fullRecipeUrl));
    }).toList();

    final responses = await Future.wait(requests);

    return responses
        .where((response) => response.statusCode == 200)
        .map((response) => Recipe.fromJson(jsonDecode(response.body)))
        .toList();
  }

}

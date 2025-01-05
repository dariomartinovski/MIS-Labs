import 'package:flutter/material.dart';
import 'package:recipes_app/models/recipe.dart';
import 'package:recipes_app/services/mock_recipe_service.dart';
import 'package:recipes_app/services/recipe_service.dart';
import 'package:recipes_app/widgets/carousel_widget.dart';
import 'package:recipes_app/widgets/result_list_widget.dart';

class SearchResultsScreen extends StatefulWidget {
  final String searchQuery;

  const SearchResultsScreen({
    super.key,
    required this.searchQuery,
  });

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  late Future<List<Recipe>> _searchResults;

  @override
  void initState() {
    super.initState();
    _searchResults = RecipeService(
        apiKey: "keyHere"
    ).fetchFullRecipesForSearch(widget.searchQuery);
//     _searchResults = MockRecipeService().fetchPopularRecipes(8);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
        backgroundColor: Colors.deepOrange,
      ),
      body: FutureBuilder<List<Recipe>>(
        future: _searchResults,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
                child: Text('No recipes found for "${widget.searchQuery}"'));
          }

          return SingleChildScrollView(
              child: ResultListWidget(
            recipes: snapshot.data!,
            searchQuery: widget.searchQuery,
          ));
        },
      ),
    );
  }
}

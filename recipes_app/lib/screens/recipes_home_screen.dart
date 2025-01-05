import 'package:flutter/material.dart';
import 'package:recipes_app/models/recipe.dart';
import 'package:recipes_app/screens/search_results_screen.dart';
import 'package:recipes_app/services/mock_recipe_service.dart';
import 'package:recipes_app/services/recipe_service.dart';
import 'package:recipes_app/widgets/carousel_widget.dart';
import 'package:recipes_app/widgets/featured_recipe_widget.dart';
import 'package:recipes_app/widgets/footer.dart';
import 'package:recipes_app/widgets/recommended_recipes_widget.dart';

class RecipeHomeScreen extends StatefulWidget {
  const RecipeHomeScreen({super.key});

  @override
  State<RecipeHomeScreen> createState() => _RecipeHomeScreenState();
}

class _RecipeHomeScreenState extends State<RecipeHomeScreen> {
  Recipe? _featuredRecipe;
  List<Recipe> _recommendedRecipes = [];
  List<Recipe> _popularRecipes = [];
  List<Recipe> _asianRecipes = [];
  List<Recipe> _italianRecipes = [];
  List<Recipe> _mediterraneanRecipes = [];
  bool isLoading = true;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  final RecipeService recipeService = RecipeService(apiKey: "keyHere");

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
//       Recipe featuredRecipe = await MockRecipeService().fetchFeaturedRecipe();
//       List<Recipe> recommendedRecipes =
//           await MockRecipeService().fetchRandomRecipes(8);
//       List<Recipe> popularRecipes =
//           await MockRecipeService().fetchPopularRecipes(8);
//       List<Recipe> asianRecipes =
//           await MockRecipeService().fetchPopularRecipes(8);
//       List<Recipe> italianRecipes =
//           await MockRecipeService().fetchPopularRecipes(8);
//       List<Recipe> mediterraneanRecipes =
//           await MockRecipeService().fetchPopularRecipes(8);
//       Fetch featured recipe(s)
      List<Recipe> featuredRecipes = await recipeService.fetchFeaturedRecipes();
      Recipe featuredRecipe = featuredRecipes.isNotEmpty ? featuredRecipes.first : throw Exception('No featured recipes found');

      List<Recipe> recommendedRecipes = await recipeService.fetchRandomRecipes(8);
      List<Recipe> popularRecipes = await recipeService.fetchPopularRecipes(8);

      List<Recipe> asianRecipes = await recipeService.fetchRandomRecipes(8, diet: 'Asian');
      List<Recipe> italianRecipes = await recipeService.fetchRandomRecipes(8, diet: 'Italian');
      List<Recipe> mediterraneanRecipes = await recipeService.fetchRandomRecipes(8, diet: 'Mediterranean');

      setState(() {
        _featuredRecipe = featuredRecipe;
        _recommendedRecipes = recommendedRecipes;
        _popularRecipes = popularRecipes;
        _asianRecipes = asianRecipes;
        _italianRecipes = italianRecipes;
        _mediterraneanRecipes = mediterraneanRecipes;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching data: $error");
    }
  }

  void _clearSearchInput() {
    _searchController.clear();
    setState(() {
      _searchQuery = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(150),
          child: AppBar(
            backgroundColor: Colors.deepOrange,
            elevation: 0,
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Icon(Icons.fastfood, size: 30),
                      const SizedBox(width: 10),
                      Text(
                        'CookUp',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search for recipes...',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          if (_searchQuery.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchResultsScreen(
                                  searchQuery: _searchQuery,
                                ),
                              ),
                            ).then((_) {
                              _searchController.clear();
                              setState(() {
                                _searchQuery = "";
                              });
                            });
                          }
                        },
                        icon: Icon(Icons.search, color: Colors.deepOrange),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_featuredRecipe != null)
                      FeaturedRecipe(recipe: _featuredRecipe!),
                    if (_recommendedRecipes.isNotEmpty)
                      RecommendedRecipes(recipes: _recommendedRecipes),
                    if (_popularRecipes.isNotEmpty)
                      CarouselWidget(
                        title: 'What our community is cooking!',
                        recipes: _popularRecipes,
                      ),
                    // Section for ideas
                    Container(
                      width: double.infinity,
                      color: Colors.grey[100],
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Need some inspiration?",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Explore our top picks from a variety of cuisines. Let us help you decide what's next on your menu!",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_italianRecipes.isNotEmpty)
                      CarouselWidget(
                        title: "Italian Cuisine",
                        subtitle:
                            "Take a look at our pick from the Italian cuisine.",
                        recipes: _italianRecipes,
                        reversed: true,
                      ),
                    if (_mediterraneanRecipes.isNotEmpty)
                      CarouselWidget(
                        title: "Mediterranean Cuisine",
                        subtitle:
                            "Our curated picks from the heart of Mediterranean flavors.",
                        recipes: _mediterraneanRecipes,
                      ),
                    if (_asianRecipes.isNotEmpty)
                      CarouselWidget(
                        title: "Asian Cuisine",
                        subtitle:
                            "Experience the rich and diverse tastes of Asia.",
                        recipes: _asianRecipes,
                        reversed: true,
                      ),
                    FooterWidget(name: "Dario Martinovski"),
                  ],
                ),
              ));
  }
}

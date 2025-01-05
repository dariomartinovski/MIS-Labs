import 'package:flutter/material.dart';
import 'package:recipes_app/helpers/BuilderHelper.dart';
import 'package:recipes_app/helpers/HtmlHelper.dart';
import 'package:recipes_app/models/recipe.dart';
import 'package:recipes_app/services/mock_recipe_service.dart';
import 'package:recipes_app/services/recipe_service.dart';
import 'package:recipes_app/widgets/carousel_widget.dart';

class RecipeDetailsScreen extends StatefulWidget {
  final Recipe recipe;
  const RecipeDetailsScreen({super.key, required this.recipe});

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  late Future<List<Recipe>> _similarRecipesFuture;

  @override
  void initState() {
    super.initState();
    _similarRecipesFuture = RecipeService(
        apiKey: "keyHere"
    ).fetchFullRecipesForSimilar(widget.recipe.id);
//     _similarRecipesFuture = MockRecipeService().fetchSimilarRecipes(widget.recipe.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: widget.recipe.image != null
                  ? Image.network(
                widget.recipe.image!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              )
                  : Image.asset(
                'assets/images/no_image_available.jpg',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.recipe.title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            if (widget.recipe.summary != null) ...[
              Text(
                stripHtmlTags(widget.recipe.summary),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 20),
            ],
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildIconDetail(Icons.timer, "${widget.recipe.readyInMinutes} min"),
                buildIconDetail(Icons.people, "${widget.recipe.servings} servings"),
                buildIconDetail(
                  Icons.thumb_up,
                  "${widget.recipe.aggregateLikes} likes",
                ),
              ],
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                if (widget.recipe.vegan) buildChip("Vegan", Icons.eco),
                if (widget.recipe.vegetarian) buildChip("Vegetarian", Icons.spa),
                if (widget.recipe.glutenFree) buildChip("Gluten-Free", Icons.no_food),
                if (widget.recipe.dairyFree) buildChip("Dairy-Free", Icons.local_drink),
                if (widget.recipe.veryHealthy) buildChip("Healthy", Icons.health_and_safety),
                if (widget.recipe.cheap) buildChip("Budget-Friendly", Icons.attach_money),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Ingredients",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ...widget.recipe.extendedIngredients.map((ingredient) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                "- ${ingredient.original}",
                style: const TextStyle(fontSize: 16),
              ),
            )),
            const SizedBox(height: 20),
            // Instructions
            const Text(
              "Instructions",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            widget.recipe.instructions != null
                ? Text(
              stripHtmlTags(widget.recipe.instructions!),
              style: const TextStyle(fontSize: 16, height: 1.5),
            )
                : const Text(
              "No instructions available.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            FutureBuilder<List<Recipe>>(
              future: _similarRecipesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text("No similar recipes found.");
                }
                final similarRecipes = snapshot.data!;
                return CarouselWidget(
                  title: "Similar Recipes",
                  recipes: similarRecipes.toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

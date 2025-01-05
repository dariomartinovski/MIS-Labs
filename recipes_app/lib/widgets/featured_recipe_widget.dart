import 'package:flutter/material.dart';
import 'package:recipes_app/helpers/HtmlHelper.dart';
import 'package:recipes_app/helpers/StringHelper.dart';
import 'package:recipes_app/models/recipe.dart';
import 'package:recipes_app/screens/recipe_details_screen.dart';

class FeaturedRecipe extends StatelessWidget {
  final Recipe recipe;

  const FeaturedRecipe({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetailsScreen(recipe: recipe),
            ),
          );
        },
        child: Card(
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Today's Top Pick",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              recipe.image != null
                  ? ClipRRect(
                // borderRadius: BorderRadius.vertical(top: Radius.circular(15), bottom: Radius.circular(15)),
                child: Image.network(
                  recipe.image!,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              )
                  : Placeholder(fallbackHeight: 200),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.title,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8),
                    recipe.summary != null
                        ? Text(
                      truncateString(
                          stripHtmlTags(recipe.summary!),
                          130
                      ),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    )
                        : Container(),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}

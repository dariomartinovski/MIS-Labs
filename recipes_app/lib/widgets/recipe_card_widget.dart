import 'package:flutter/material.dart';
import 'package:recipes_app/helpers/StringHelper.dart';
import 'package:recipes_app/models/recipe.dart';
import 'package:recipes_app/screens/recipe_details_screen.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({super.key, required this.recipe});

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
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 115,
              width: double.infinity,
              child: recipe.image != null
                  ? Image.network(
                recipe.image!,
                fit: BoxFit.cover,
              )
                  : Image.asset(
                'assets/images/no_image_available.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (recipe.readyInMinutes != null)
                    Row(
                      children: [
                        Icon(Icons.timer, size: 12, color: Colors.grey[600]),
                        SizedBox(width: 5),
                        Text(
                          '${recipe.readyInMinutes} mins',
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        )
                      ],
                    ),
                  SizedBox(height: 5),
                  Text(
                    truncateString(recipe.title, 32),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:recipes_app/helpers/StringHelper.dart';
import 'package:recipes_app/models/recipe.dart';
import 'package:recipes_app/screens/recipe_details_screen.dart';

class CarouselRecipeCard extends StatelessWidget {
  final Recipe recipe;

  const CarouselRecipeCard({super.key, required this.recipe});

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
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: SizedBox(
                height: 115,
                width: 200,
                child: recipe.image != null && recipe.image!.isNotEmpty
                    ? Image.network(
                  recipe.image!,
                  fit: BoxFit.cover,
                )
                    : Image.asset(
                  'assets/images/no_image_available.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (recipe.readyInMinutes != null || recipe.servings != null)
                    Row(
                      children: [
                        if (recipe.readyInMinutes != null)
                          Row(
                            children: [
                              Icon(Icons.timer, size: 13, color: Colors.grey[600]),
                              SizedBox(width: 5),
                              Text(
                                '${recipe.readyInMinutes} mins',
                                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        if (recipe.readyInMinutes != null && recipe.servings != null)
                          SizedBox(width: 15),
                        if (recipe.servings != null)
                          Row(
                            children: [
                              Icon(Icons.group, size: 13, color: Colors.grey[600]),
                              SizedBox(width: 5),
                              Text(
                                '${recipe.servings} servings',
                                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                              ),
                            ],
                          ),
                      ],
                    ),
                  SizedBox(height: 5),
                  Text(
                    truncateString(recipe.title, 30),
                    style: TextStyle(
                      fontSize: 12,
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

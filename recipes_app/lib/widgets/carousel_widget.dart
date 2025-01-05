import 'package:flutter/material.dart';
import 'package:recipes_app/models/recipe.dart';
import 'package:recipes_app/widgets/carousel_recipe_card.dart';
import 'package:recipes_app/widgets/recipe_card_widget.dart';

class CarouselWidget extends StatefulWidget {
  final String title;
  final String? subtitle;
  final List<Recipe> recipes;
  final reversed;

  const CarouselWidget({super.key, required this.title, this.subtitle, required this.recipes, this.reversed = false});

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.reversed){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            widget.title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        if (widget.subtitle != null)
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 4.0, right: 16.0, bottom: 0),
            child: Text(
              widget.subtitle!,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: widget.recipes.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child:
                CarouselRecipeCard(recipe: widget.recipes[index]),
              );
            },
          ),
        ),
      ],
    );  }
}
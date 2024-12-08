import 'package:flutter/material.dart';
import 'package:mis_lab2/model/JokeType.dart';
import 'package:mis_lab2/screens/jokelist_screen.dart';

class JokeTypesGrid extends StatefulWidget {
  final List<JokeType> jokeTypes;

  const JokeTypesGrid({super.key, required this.jokeTypes});

  @override
  State<JokeTypesGrid> createState() => _JokeTypesGridState();
}

class _JokeTypesGridState extends State<JokeTypesGrid> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const Text(
          "Joke Types",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Choose one of the types",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
            child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8,
                childAspectRatio: 2.5,
                children: widget.jokeTypes.map((jokeType) {
                  return TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  JokeListScreen(jokeType: jokeType)));
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      jokeType.type,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }).toList()))
      ]),
    );
  }
}

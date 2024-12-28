import 'package:flutter/material.dart';
import 'package:mis_lab2/model/Joke.dart';

class JokeCard extends StatelessWidget {
  final Joke joke;
  final Function(Joke) onFavoriteToggle;  // Callback to handle favorite toggling

  const JokeCard({super.key, required this.joke, required this.onFavoriteToggle});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Joke ID: ${joke.id}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Setup: ${joke.setup}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Punchline: ${joke.punchline}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    // Call the callback function to toggle favorite
                    onFavoriteToggle(joke);
                  },
                  icon: Icon(
                    joke.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: joke.isFavorite ? Colors.red : Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

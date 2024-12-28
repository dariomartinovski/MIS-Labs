import 'package:flutter/material.dart';
import 'package:mis_lab2/model/Joke.dart';
import 'package:mis_lab2/services/FirebaseService.dart';
import 'package:mis_lab2/widgets/JokeCard.dart';

class FavoriteJokesScreen extends StatefulWidget {
  const FavoriteJokesScreen({super.key});

  @override
  State<FavoriteJokesScreen> createState() => _FavoriteJokesScreenState();
}

class _FavoriteJokesScreenState extends State<FavoriteJokesScreen> {
  List<Joke> _favoriteJokes = [];
  bool _isLoading = true;
  final FirebaseService _firebaseService = FirebaseService();

  @override
  void initState() {
    super.initState();
    getFavoriteJokes();
  }

  Future<void> getFavoriteJokes() async {
    final jokes = await _firebaseService.getFavoriteJokes();
    setState(() {
      _favoriteJokes = jokes;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Jokes'),
        backgroundColor: Colors.redAccent[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: _isLoading
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : _favoriteJokes.isEmpty
            ? const Center(
          child: Text(
            'No favorite jokes yet!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        )
            : ListView.builder(
          itemCount: _favoriteJokes.length,
          itemBuilder: (context, index) {
            final joke = _favoriteJokes[index];
            return JokeCard(
              joke: joke,
              onFavoriteToggle: (Joke joke) {
                setState(() {
                  joke.isFavorite = !joke.isFavorite;
                  if (joke.isFavorite) {
                    _firebaseService.saveFavoriteJoke(joke);
                  } else {
                    _firebaseService.removeFavoriteJoke(joke);
                  }
                });
              },
            );
          },
        ),
      ),
    );
  }
}
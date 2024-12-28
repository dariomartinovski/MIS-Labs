import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mis_lab2/model/Joke.dart';
import 'package:mis_lab2/model/JokeType.dart';
import 'package:mis_lab2/screens/favorites_screen.dart';
import 'package:mis_lab2/services/ApiService.dart';
import 'package:mis_lab2/services/AuthService.dart';
import 'package:mis_lab2/services/FirebaseService.dart';
import 'package:mis_lab2/widgets/JokeCard.dart';

class JokeListScreen extends StatefulWidget {
  final JokeType jokeType;

  const JokeListScreen({super.key, required this.jokeType});

  @override
  State<JokeListScreen> createState() => _JokeListScreenState();
}

class _JokeListScreenState extends State<JokeListScreen> {
  List<Joke> _jokes = [];
  final FirebaseService _firebaseService = FirebaseService();
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    getJokesForTypeFromApi();
  }

  void getJokesForTypeFromApi() async {
    ApiService.getJokesForTypeFromJokeApi(widget.jokeType).then((response) {
      var data = List.of(json.decode(response.body));
      setState(() {
        _jokes = data.asMap().entries.map<Joke>((element) {
          return Joke.fromJson(element.value);
        }).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[100],
        title: const Text("Jokes App",
            style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _authService.logout(context),
          ),
          IconButton(
            icon: const Icon(Icons.favorite), // Heart icon
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoriteJokesScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: _jokes.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Text(
                    "Jokes for type ${widget.jokeType.type}",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _jokes.length,
                      itemBuilder: (context, index) {
                        final joke = _jokes[index];
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
                ],
              ),
      ),
    );
  }
}

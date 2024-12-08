import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mis_lab2/model/Joke.dart';
import 'package:mis_lab2/model/JokeType.dart';
import 'package:mis_lab2/screens/randomjoke_screen.dart';
import 'package:mis_lab2/services/ApiService.dart';

class JokeListScreen extends StatefulWidget {
  final JokeType jokeType;

  const JokeListScreen({super.key, required this.jokeType});

  @override
  State<JokeListScreen> createState() => _JokeListScreenState();
}

class _JokeListScreenState extends State<JokeListScreen> {
  List<Joke> _jokes = [];

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
        title: const Text("Jokes App", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
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
                              ],
                            ),
                          ),
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

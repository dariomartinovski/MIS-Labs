import 'package:flutter/material.dart';
import 'package:mis_lab2/model/JokeType.dart';
import 'package:mis_lab2/screens/randomjoke_screen.dart';
import 'dart:convert';

import 'package:mis_lab2/services/ApiService.dart';
import 'package:mis_lab2/widgets/JokeTypesGrid.dart';

class JokeTypesScreen extends StatefulWidget {
  const JokeTypesScreen({super.key});

  @override
  State<JokeTypesScreen> createState() => _JokeTypesScreenState();
}

class _JokeTypesScreenState extends State<JokeTypesScreen> {
  List<JokeType> jokeTypes = [];

  @override
  void initState() {
    super.initState();
    getJokeTypesFromApi();
  }

  void getJokeTypesFromApi() async {
    ApiService.getJokeTypesFromApi().then((response) {
      var data = List.of(json.decode(response.body));
      setState(() {
        jokeTypes = data.map((element){
          return JokeType(type: element);
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
        actions: [
          IconButton(
            icon: Icon(Icons.shuffle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RandomJokeScreen()),
              );
            },
          ),
        ],
      ),
      body: JokeTypesGrid(jokeTypes: jokeTypes),
    );
  }
}

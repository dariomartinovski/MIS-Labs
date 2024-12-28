import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mis_lab2/model/JokeType.dart';
import 'package:mis_lab2/screens/favorites_screen.dart';
import 'package:mis_lab2/screens/login_screen.dart';
import 'package:mis_lab2/screens/randomjoke_screen.dart';
import 'dart:convert';

import 'package:mis_lab2/services/ApiService.dart';
import 'package:mis_lab2/services/AuthService.dart';
import 'package:mis_lab2/widgets/JokeTypesGrid.dart';

class JokeTypesScreen extends StatefulWidget {
  const JokeTypesScreen({super.key});

  @override
  State<JokeTypesScreen> createState() => _JokeTypesScreenState();
}

class _JokeTypesScreenState extends State<JokeTypesScreen> {
  List<JokeType> jokeTypes = [];
  final AuthService _authService = AuthService();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    getJokeTypesFromApi();

    _firebaseMessaging.requestPermission();

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        print('Foreground Notification: ${message.notification?.title}');
        print('Foreground Notification Body: ${message.notification?.body}');
        // Optionally show a dialog or local notification
      }
    });

    // Handle messages when app is opened from notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification Clicked: ${message.notification?.title}');
      // Navigate to a specific screen if needed
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => JokeTypesScreen()),
      );
    });
  }

  void getJokeTypesFromApi() async {
    ApiService.getJokeTypesFromApi().then((response) {
      var data = List.of(json.decode(response.body));
      setState(() {
        jokeTypes = data.map((element) {
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
        title: const Text("Jokes App",
            style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shuffle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RandomJokeScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _authService.logout(context),
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
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
      body: JokeTypesGrid(jokeTypes: jokeTypes),
    );
  }
}

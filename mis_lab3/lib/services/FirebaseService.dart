import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:mis_lab2/model/Joke.dart';
import 'package:mis_lab2/screens/randomjoke_screen.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}

final navigatorKey = GlobalKey<NavigatorState>();

class FirebaseService {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print("FCM token is $fCMToken");
    await _firebaseMessaging.subscribeToTopic('all');
    initPushNotifications();
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    navigatorKey.currentState?.pushNamed(
      RandomJokeScreen.route,
      arguments: message
    );
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<void> saveFavoriteJoke(Joke joke) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }

    final userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
    final favoritesRef = userRef.collection('favorites');

    await favoritesRef.doc(joke.id.toString()).set(joke.toJson());
  }

  Future<void> removeFavoriteJoke(Joke joke) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }

    final userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
    final favoritesRef = userRef.collection('favorites');

    await favoritesRef.doc(joke.id.toString()).delete();
  }

  Future<List<Joke>> getFavoriteJokes() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return [];
    }

    final userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
    final favoritesRef = userRef.collection('favorites');

    try {
      final snapshot = await favoritesRef.get();
      return snapshot.docs
          .map((doc) => Joke.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print("Error fetching favorite jokes: $e");
      return [];
    }
  }
}

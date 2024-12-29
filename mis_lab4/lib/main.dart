import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:mis_lab4/model/Exam.dart';
import 'package:mis_lab4/screens/calendar_screen.dart';
import 'package:mis_lab4/services/location_service.dart';
import 'package:mis_lab4/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await LocationService.requestLocationPermission();
    await NotificationService.initializeNotification();

  runApp(const ExamGeofenceApp());
}

void scheduleLocationReminder(Exam exam) {
  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 10,
      channelKey: 'basic_channel',
      title: 'Reminder for ${exam.title}',
      body: 'Exam at ${ exam.location} is approaching!',
    ),
    schedule: NotificationCalendar.fromDate(date: exam.dateTime),
  );
}

class ExamGeofenceApp extends StatelessWidget {
  const ExamGeofenceApp({super.key});
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exam Geofence',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CalendarScreen(),
    );
  }
}

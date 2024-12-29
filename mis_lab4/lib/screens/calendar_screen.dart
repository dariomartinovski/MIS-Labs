import 'package:flutter/material.dart';
import 'package:mis_lab4/screens/map_screen.dart';
import 'package:mis_lab4/screens/add_exam_screen.dart';
import 'package:mis_lab4/services/location_reminder_service.dart';
import 'package:mis_lab4/widgets/calendar_widget.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final LocationReminderService _locationReminderService = LocationReminderService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exam Geofence'),
        actions: [
          IconButton(
            icon: const Icon(Icons.map),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MapScreen()),
              );
            },
          ),
        ],
      ),
      body: const Column(
        children: [
          CalendarWidget(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddExamScreen()),
          );
        },
        tooltip: 'Add New Exam',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _locationReminderService.startTracking();
  }

  @override
  void dispose() {
    _locationReminderService.stopTracking();
    super.dispose();
  }
}

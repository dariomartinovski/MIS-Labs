import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:mis_lab4/model/Exam.dart';
import 'package:mis_lab4/services/exam_service.dart';
import 'package:mis_lab4/services/notification_service.dart';

class LocationReminderService {
  Timer? _timer;
  final ExamService examService = ExamService();
  static const double radius = 1000.0;

  Future<void> checkNearbyExams() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    for (var exam in examService.fetchExams()) {
      double distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        exam.latitude,
        exam.longitude,
      );

      if (distance <= radius) {
        _sendNotification(exam);
      }
    }
  }

  void _sendNotification(Exam exam) async {
    await NotificationService.showNotification(
        title: exam.title,
        body: 'Your ${exam.title} is at ${exam.location}.'
    );
  }

  void startTracking() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      checkNearbyExams();
    });
  }

  void stopTracking() {
    _timer?.cancel();
  }
}

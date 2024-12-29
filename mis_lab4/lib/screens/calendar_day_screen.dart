import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mis_lab4/model/Exam.dart';
import 'package:mis_lab4/services/exam_service.dart';
import 'package:mis_lab4/widgets/exam_widget.dart';

class CalendarDay extends StatelessWidget {
  final DateTime selectedDay;
  final ExamService _examService = ExamService();

  CalendarDay({super.key, required this.selectedDay});

  @override
  Widget build(BuildContext context) {
    List<Exam> exams = _getEventsForDay(selectedDay);
    String formattedDate = DateFormat('dd.MM.yyyy').format(selectedDay);

    return Scaffold(
      appBar: AppBar(
        title: Text('Exams on $formattedDate'),
        centerTitle: true,
      ),
      body: exams.isEmpty
          ? Center(
              child: Text(
              'No exams for this day',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ))
          : ListView.builder(
              itemCount: exams.length,
              itemBuilder: (context, index) {
                return ExamCard(exam: exams[index]);
              },
            ),
    );
  }

  List<Exam> _getEventsForDay(DateTime day) {
    return _examService.fetchExamsForDay(day);
  }
}

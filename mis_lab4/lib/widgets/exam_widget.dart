import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mis_lab4/model/Exam.dart';

class ExamCard extends StatelessWidget {
  final Exam exam;

  const ExamCard({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    String formattedTime = DateFormat('HH:mm').format(exam.dateTime);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          exam.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Time: $formattedTime',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            Text(
              'Location: ${exam.location}',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        trailing: const Icon(
          Icons.access_time,
          color: Colors.blue,
        ),
        onTap: () {
          //TODO maybe add this?
          print("tapped");
        },
      ),
    );
  }
}

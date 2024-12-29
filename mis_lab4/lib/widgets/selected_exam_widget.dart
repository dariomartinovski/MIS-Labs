import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mis_lab4/model/Exam.dart';

class SelectedExamBottomSheet extends StatelessWidget {
  final Exam? selectedExam;
  final VoidCallback onClose;
  final VoidCallback onViewExams;
  final VoidCallback onGetDirections; // Callback to get directions

  const SelectedExamBottomSheet({
    super.key,
    required this.selectedExam,
    required this.onClose,
    required this.onViewExams,
    required this.onGetDirections, // Receiving the callback
  });

  @override
  Widget build(BuildContext context) {
    if (selectedExam == null) return const SizedBox.shrink();

    return Container(
      height: 270,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: const BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.black),
              onPressed: onClose,
            ),
          ),
          Text(
            selectedExam!.title,
            style: const TextStyle(
              color: Color(0xFF333333),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Date: ${DateFormat('dd:MM:yyyy').format(selectedExam!.dateTime)}',
            style: const TextStyle(
              color: Color(0xFF333333),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Time: ${DateFormat('HH:mm').format(selectedExam!.dateTime)}',
            style: const TextStyle(
              color: Color(0xFF333333),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF257E8C), // Bluish button color #257E8C
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: onGetDirections,
                icon: const Icon(Icons.directions, color: Colors.white), // White icon
                label: const Text(
                  'Get Directions',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF257E8C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: onViewExams,
                child: const Text(
                  'View exams on this day',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

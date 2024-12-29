import 'package:mis_lab4/model/Exam.dart';

class ExamService {
  static final ExamService _instance = ExamService._internal();

  factory ExamService() {
    return _instance;
  }

  ExamService._internal();

  final List<Exam> _mockExams = [
    Exam(
      id: '1',
      title: 'Math Exam',
      dateTime: DateTime(2024, 12, 27, 9, 0),
      location: 'Кај Сити Мол',
      latitude: 42.003903,
      longitude: 21.392079,
    ),
    Exam(
      id: '2',
      title: 'Physics Exam',
      dateTime: DateTime(2024, 12, 25, 14, 0),
      location: 'Кај Мартини Бар',
      latitude: 42.002843,
      longitude: 21.401444,
    ),
    Exam(
      id: '3',
      title: 'History Exam',
      dateTime: DateTime(2024, 12, 26, 11, 30),
      location: 'Барака 3.2',
      latitude: 42.002716,
      longitude: 21.409223,
    ),
    Exam(
      id: '4',
      title: 'Computer Science Exam',
      dateTime: DateTime(2024, 12, 27, 10, 0),
      location: 'АМФ Г',
      latitude: 42.004364,
      longitude: 21.409049,
    ),
  ];

  List<Exam> fetchExams() {
    return _mockExams;
  }

  List<Exam> fetchExamsForDay(DateTime day) {
    return _mockExams.where((exam) {
      return exam.dateTime.year == day.year &&
          exam.dateTime.month == day.month &&
          exam.dateTime.day == day.day;
    }).toList();
  }

  void addExam(Exam newExam) {
    final newId = (_mockExams.length + 1).toString();
    final examWithId = Exam(
      id: newId,
      title: newExam.title,
      dateTime: newExam.dateTime,
      location: newExam.location,
      latitude: newExam.latitude,
      longitude: newExam.longitude,
    );

    _mockExams.add(examWithId);
  }
}

import 'dart:ffi';

class Exam {
  final String id;
  final String title;
  final DateTime dateTime;
  final String location;
  final double latitude;
  final double longitude;

  Exam({
    required this.id,
    required this.title,
    required this.dateTime,
    required this.location,
    required this.latitude,
    required this.longitude
  });

  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      id: json['id'] as String,
      title: json['title'] as String,
      dateTime: DateTime.parse(json['dateTime']),
      location: json['location'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'dateTime': dateTime.toIso8601String(),
      'location': location,
      'latitude': latitude,
      'longitude': longitude
    };
  }
}

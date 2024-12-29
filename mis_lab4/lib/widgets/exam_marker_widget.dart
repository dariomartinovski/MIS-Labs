import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mis_lab4/model/Exam.dart';

class ExamMarker {
  static Marker build(Exam exam, VoidCallback onTap) {
    return Marker(
      point: LatLng(
        exam.latitude,
        exam.longitude
        // double.tryParse(exam.latitude) ?? 41.9981,
        // double.tryParse(exam.longitude) ?? 21.4254,
      ),
      width: 40,
      height: 40,
      key: Key(exam.id.toString()),
      child: GestureDetector(
        onTap: onTap,
        child: const Icon(
          Icons.location_on,
          color: Colors.red,
          size: 40,
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class UserMarker {
  static Marker build(LatLng userLocation) {
    return Marker(
      point: userLocation,
      width: 40,
      height: 40,
      child: const Icon(
        Icons.person_pin_circle,
        color: Colors.blue,
        size: 40,
      ),
    );
  }
}
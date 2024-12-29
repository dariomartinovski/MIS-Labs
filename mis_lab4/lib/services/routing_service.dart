import 'dart:convert';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class RoutingService {
  Future<List<LatLng>> getRoute(LatLng start, LatLng end) async {
    final url =
        'https://router.project-osrm.org/route/v1/driving/${start.longitude},${start.latitude};${end.longitude},${end.latitude}?overview=full&geometries=polyline';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final encodedPolyline = data['routes'][0]['geometry'];
      // Decode the polyline into a list of LatLng points.
      final polylinePoints = PolylinePoints().decodePolyline(encodedPolyline);
      return polylinePoints
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();
    } else {
      throw Exception('Failed to fetch route from OSRM');
    }
  }
}
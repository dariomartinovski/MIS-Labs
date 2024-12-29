import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:mis_lab4/model/Exam.dart';
import 'package:mis_lab4/screens/calendar_day_screen.dart';
import 'package:mis_lab4/services/exam_service.dart';
import 'package:mis_lab4/services/location_service.dart';
import 'package:mis_lab4/services/routing_service.dart';
import 'package:mis_lab4/widgets/exam_marker_widget.dart';
import 'package:mis_lab4/widgets/selected_exam_widget.dart';
import 'package:mis_lab4/widgets/user_marker_widget.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final ExamService _examService = ExamService();
  final MapController _mapController = MapController();
  final LocationService _locationService = LocationService();
  final RoutingService _routingService = RoutingService();

  Exam? _selectedExam;
  late Position _userLocation;
  late bool _locationFetched = false;

  List<LatLng> _routePoints = [];
  bool _isLoadingRoute = false;

  @override
  void initState() {
    super.initState();
    _fetchUserLocation();
  }

  Future<void> _fetchUserLocation() async {
    try {
      final position = await _locationService.getUserLocation();
      setState(() {
        _userLocation = position;
        _locationFetched = true;
      });
    } catch (e) {
      print('Error fetching user location: $e');
    }
  }

  Future<void> _fetchRoute(LatLng examLocation) async {
    try {
      setState(() {
        _isLoadingRoute = true;
        _routePoints = [];
      });
      final route = await _routingService.getRoute(
        LatLng(_userLocation.latitude, _userLocation.longitude),
        examLocation,
      );
      setState(() {
        _routePoints = route;
        _isLoadingRoute = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingRoute = false;
      });
      print('Error fetching route: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Exam> exams = _examService.fetchExams();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exams Map'),
        actions: [
          IconButton(
            icon: const Icon(Icons.location_searching),
            onPressed: () {
              if (_locationFetched) {
                _mapController.move(
                  LatLng(_userLocation.latitude, _userLocation.longitude),
                  15.0,
                );
              }
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _locationFetched
                  ? LatLng(_userLocation.latitude, _userLocation.longitude)
                  : const LatLng(41.9981, 21.4254),
              initialZoom: 12.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),
              MarkerLayer(
                markers: [
                  if (_locationFetched)
                    UserMarker.build(
                      LatLng(_userLocation.latitude, _userLocation.longitude),
                    ),
                  ...exams.map((exam) {
                    return ExamMarker.build(
                      exam,
                          () async {
                        setState(() {
                          _selectedExam = exam;
                        });
                      },
                    );
                  }),
                ],
              ),
              if (_routePoints.isNotEmpty)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: _routePoints,
                      color: Colors.blue,
                      strokeWidth: 4.0,
                    ),
                  ],
                ),
            ],
          ),
          if (_isLoadingRoute)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
      bottomSheet: _selectedExam != null
          ? SelectedExamBottomSheet(
        selectedExam: _selectedExam!,
        onClose: () {
          setState(() {
            _selectedExam = null;
            _routePoints = [];
          });
        },
        onViewExams: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CalendarDay(
                selectedDay: _selectedExam!.dateTime,
              ),
            ),
          );
        },
        onGetDirections: () async {
          await _fetchRoute(
            LatLng(
              _selectedExam!.latitude,
              _selectedExam!.longitude
              // double.parse(_selectedExam!.latitude),
              // double.parse(_selectedExam!.longitude),
            ),
          );
        },
      )
          : const SizedBox.shrink(),
    );
  }
}
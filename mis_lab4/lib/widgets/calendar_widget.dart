import 'package:flutter/material.dart';
import 'package:mis_lab4/screens/calendar_day_screen.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final DateTime _focusedDay = DateTime.now();
  DateTime today = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  void _onDaySelected(DateTime day, DateTime focusDay) {
    setState(() {
      _selectedDay = day;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CalendarDay(selectedDay: _selectedDay!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(children: [
          TableCalendar(
              headerStyle: const HeaderStyle(
                  formatButtonVisible: false, titleCentered: true),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
              focusedDay: _focusedDay,
              firstDay: DateTime.utc(2010, 1, 1),
              lastDay: DateTime.utc(2030, 1, 1),
              onDaySelected: _onDaySelected),
        ]));
  }
}

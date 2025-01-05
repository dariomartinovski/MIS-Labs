// Helper to build an icon with text for details
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildIconDetail(IconData icon, String label) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, size: 32, color: Colors.deepOrange),
      const SizedBox(height: 5),
      Text(
        label,
        style: const TextStyle(fontSize: 16),
      ),
    ],
  );
}

// Helper to build a styled chip
Widget buildChip(String label, IconData icon) {
  return Chip(
    avatar: Icon(icon, size: 18, color: Colors.white),
    label: Text(
      label,
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.deepOrange,
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  );
}
import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  final String name;

  const FooterWidget({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.grey[200],
        child: Center(
          child: Text(
            '© ${DateTime.now().year} $name',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class InformationSection extends StatelessWidget {
  final String title;

  const InformationSection({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          'Information section for $title',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
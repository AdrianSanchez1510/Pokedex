import 'package:flutter/material.dart';

class SideIndex extends StatelessWidget {
  const SideIndex({super.key});

  static const List<String> items = [
    '1. Search Pokémon',
    '2. Pokémon Info',
    '3. Types',
    '4. Stats',
    '5. Abilities',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      color: Colors.grey.shade100,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: ListView(
        children: items
            .map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
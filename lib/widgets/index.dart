import 'package:flutter/material.dart';

class SideIndex extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const SideIndex({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  static const List<String> items = [
    'Introduction',
    'Getting Started',
    'Installation',
    'Configuration',
    'API Reference',
    'Examples',
    'FAQ',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: Colors.grey.shade100,
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;

          return InkWell(
            onTap: () => onSelected(index),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              color: isSelected
                  ? Colors.blue.shade100
                  : Colors.transparent,
              child: Text(
                '${index + 1}. ${items[index]}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
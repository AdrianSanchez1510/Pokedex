import 'package:flutter/material.dart';
import '../widgets/index.dart';
import '../widgets/searchbar.dart';
import '../widgets/info.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<String> sections = [
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
    return Scaffold(
      body: Row(
        children: [
          SideIndex(
            selectedIndex: selectedIndex,
            onSelected: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),

          const VerticalDivider(width: 1),

          Expanded(
            child: Column(
              children: [
                TopSearchBar(title: sections[selectedIndex]),
                const Divider(height: 1),
                InformationSection(title: sections[selectedIndex]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
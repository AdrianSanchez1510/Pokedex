import 'package:flutter/material.dart';

class TopSearchBar extends StatefulWidget {
  final void Function(String query) onSearch;

  const TopSearchBar({
    super.key,
    required this.onSearch,
  });

  @override
  State<TopSearchBar> createState() => _TopSearchBarState();
}

class _TopSearchBarState extends State<TopSearchBar> {
  final TextEditingController controller = TextEditingController();

  void search() {
    widget.onSearch(controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Text(
            'Pokédex',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          SizedBox(
            width: 300,
            child: TextField(
              controller: controller,
              onChanged: widget.onSearch,
              onSubmitted: (_) => search(),
              decoration: InputDecoration(
                hintText: 'Search Pokémon...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
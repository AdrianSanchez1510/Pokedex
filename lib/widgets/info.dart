import 'package:flutter/material.dart';
import '../models/pokemon.dart';

class InformationSection extends StatelessWidget {
  final Pokemon? pokemon;
  final bool isLoading;
  final String? error;

  const InformationSection({
    super.key,
    required this.pokemon,
    required this.isLoading,
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Expanded(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (error != null) {
      return Expanded(
        child: Center(
          child: Text(
            error!,
            style: const TextStyle(color: Colors.red, fontSize: 18),
          ),
        ),
      );
    }

    if (pokemon == null) {
      return const Expanded(
        child: Center(child: Text('Search for a Pokémon')),
      );
    }

    return Expanded(
      child: Center(
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(
                  pokemon!.imageUrl,
                  width: 150,
                  height: 150,
                ),
                Text(
                  '#${pokemon!.id} ${pokemon!.name.toUpperCase()}',
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text('Types: ${pokemon!.types.join(', ')}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
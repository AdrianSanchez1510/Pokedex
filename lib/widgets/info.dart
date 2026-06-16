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
  child: SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.network(
                        pokemon!.imageUrl,
                        width: 120,
                        height: 120,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '#${pokemon!.id} ${pokemon!.name.toUpperCase()}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('Type: ${pokemon!.types.join(', ')}'),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(width: 24),

            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Details',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _info('Weight', '${pokemon!.weight}'),
                      _info('Height', '${pokemon!.height}'),
                      _info('Species', pokemon!.species),
                      _info('Egg Groups', pokemon!.eggGroups.join(', ')),
                      _info('Abilities', pokemon!.abilities.join(', ')),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  'Evolution Line',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: pokemon!.evolutions.map((evo) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            Image.network(
                              evo.imageUrl,
                              width: 90,
                              height: 90,
                            ),
                            Text(evo.name.toUpperCase()),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);
  }

  Widget _info(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        '$label: $value',
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
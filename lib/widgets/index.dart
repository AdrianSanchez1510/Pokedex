import 'package:flutter/material.dart';
import '../models/pokemonSumm.dart';
class SideIndex extends StatelessWidget {
  final List<PokemonSummary> pokemonList;
  final bool isLoading;
  final Function(String) onPokemonSelected;

  const SideIndex({
    super.key,
    required this.pokemonList,
    required this.isLoading,
    required this.onPokemonSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SizedBox(
        width: 250,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return Container(
      width: 250,
      color: const Color.fromARGB(255, 255, 154, 154),
      child: ListView.builder(
        itemCount: pokemonList.length,
        itemBuilder: (context, index) {
          final pokemon = pokemonList[index];

          return ListTile(
            dense: true,
            title: Text(
              '#${pokemon.id.toString().padLeft(4, '0')} ${pokemon.name}',
            ),
            onTap: () {
              onPokemonSelected(pokemon.name);
            },
          );
        },
      ),
    );
  }
}
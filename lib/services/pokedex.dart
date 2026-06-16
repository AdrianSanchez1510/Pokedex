import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/pokemon.dart';
import '../models/pokemonSumm.dart';

class Pokedex {
  static Future<Pokemon> fetchPokemon(String nameOrId) async {
    final query = nameOrId.toLowerCase().trim();

    final pokemonResponse = await http.get(
      Uri.parse('https://pokeapi.co/api/v2/pokemon/$query'),
    );

    if (pokemonResponse.statusCode != 200) {
      throw Exception('Pokemon not found');
    }

    final pokemonJson = jsonDecode(pokemonResponse.body);

    final speciesUrl = pokemonJson['species']['url'];
    final speciesResponse = await http.get(Uri.parse(speciesUrl));
    final speciesJson = jsonDecode(speciesResponse.body);

    final evolutionUrl = speciesJson['evolution_chain']['url'];
    final evolutionResponse = await http.get(Uri.parse(evolutionUrl));
    final evolutionJson = jsonDecode(evolutionResponse.body);

    final evolutionNames = _extractEvolutionNames(evolutionJson['chain']);

    final evolutions = <EvolutionPokemon>[];

    for (final name in evolutionNames) {
      final evoResponse = await http.get(
        Uri.parse('https://pokeapi.co/api/v2/pokemon/$name'),
      );

      if (evoResponse.statusCode == 200) {
        final evoJson = jsonDecode(evoResponse.body);

        evolutions.add(
          EvolutionPokemon(
            name: name,
            imageUrl: evoJson['sprites']['front_default'] ?? '',
          ),
        );
      }
    }

    return Pokemon(
      id: pokemonJson['id'],
      name: pokemonJson['name'],
      imageUrl: pokemonJson['sprites']['front_default'] ?? '',
      types: (pokemonJson['types'] as List)
          .map((typeData) => typeData['type']['name'].toString())
          .toList(),
      weight: pokemonJson['weight'],
      height: pokemonJson['height'],
      species: pokemonJson['species']['name'],
      eggGroups: (speciesJson['egg_groups'] as List)
          .map((egg) => egg['name'].toString())
          .toList(),
      abilities: (pokemonJson['abilities'] as List)
          .map((ability) => ability['ability']['name'].toString())
          .toList(),
      evolutions: evolutions,
    );
  }

  static List<String> _extractEvolutionNames(Map<String, dynamic> chain) {
    final names = <String>[];

    void walk(Map<String, dynamic> node) {
      names.add(node['species']['name']);

      final evolvesTo = node['evolves_to'] as List;

      for (final evolution in evolvesTo) {
        walk(evolution);
      }
    }

    walk(chain);
    return names;
  }

  static Future<List<PokemonSummary>> fetchPokemonList() async {
    final response = await http.get(
      Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=1025'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load Pokémon list');
    }

    final data = jsonDecode(response.body);
    final results = data['results'] as List;

    return List.generate(results.length, (index) {
      return PokemonSummary(
        id: index + 1,
        name: results[index]['name'],
      );
    });
  }
}
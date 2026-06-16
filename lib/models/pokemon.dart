class EvolutionPokemon {
  final String name;
  final String imageUrl;

  EvolutionPokemon({
    required this.name,
    required this.imageUrl,
  });
}

class Pokemon {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;

  final int weight;
  final int height;
  final String species;
  final List<String> eggGroups;
  final List<String> abilities;
  final List<EvolutionPokemon> evolutions;

  Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.weight,
    required this.height,
    required this.species,
    required this.eggGroups,
    required this.abilities,
    required this.evolutions,
  });
}
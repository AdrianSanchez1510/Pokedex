import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/models/pokemon.dart';

void main() {
  test('Pokemon object stores data correctly', () {
    final pokemon = Pokemon(
      id: 1,
      name: 'bulbasaur',
      imageUrl: 'image.png',
      types: ['grass', 'poison'],
      weight: 69,
      height: 7,
      species: 'bulbasaur',
      eggGroups: ['monster', 'plant'],
      abilities: ['overgrow', 'chlorophyll'],
      evolutions: [
        EvolutionPokemon(
          name: 'ivysaur',
          imageUrl: 'ivysaur.png',
        ),
      ],
    );

    expect(pokemon.id, 1);
    expect(pokemon.name, 'bulbasaur');
    expect(pokemon.types.length, 2);
    expect(pokemon.abilities, contains('overgrow'));
    expect(pokemon.evolutions.first.name, 'ivysaur');
  });
}
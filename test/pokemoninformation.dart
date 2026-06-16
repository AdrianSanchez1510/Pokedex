import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/widgets/info.dart';

void main() {
  testWidgets('InformationSection shows pokemon data', (tester) async {
    final pokemon = Pokemon(
      id: 25,
      name: 'pikachu',
      imageUrl: '',
      types: ['electric'],
      weight: 60,
      height: 4,
      species: 'pikachu',
      eggGroups: ['ground', 'fairy'],
      abilities: ['static', 'lightning-rod'],
      evolutions: [
        EvolutionPokemon(name: 'pichu', imageUrl: ''),
        EvolutionPokemon(name: 'pikachu', imageUrl: ''),
        EvolutionPokemon(name: 'raichu', imageUrl: ''),
      ],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: InformationSection(
            pokemon: pokemon,
            isLoading: false,
            error: null,
          ),
        ),
      ),
    );

    expect(find.text('#25 PIKACHU'), findsOneWidget);
    expect(find.text('Type: electric'), findsOneWidget);
    expect(find.text('Weight: 60'), findsOneWidget);
    expect(find.text('Height: 4'), findsOneWidget);
    expect(find.text('Species: pikachu'), findsOneWidget);
    expect(find.text('PICHU'), findsOneWidget);
    expect(find.text('RAICHU'), findsOneWidget);
  });

  testWidgets('InformationSection shows loading state', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: InformationSection(
            pokemon: null,
            isLoading: true,
            error: null,
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
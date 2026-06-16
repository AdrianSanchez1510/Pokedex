import 'package:flutter/material.dart';
import '../widgets/index.dart';
import '../models/pokemon.dart';
import '../widgets/searchbar.dart';
import '../widgets/info.dart';
import '../services/pokedex.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Pokemon? pokemon;
  bool isLoading = false;
  String? error;

  Future<void> searchPokemon(String query) async {
    setState(() {
      isLoading = true;
      error = null;
      pokemon = null;
    });

    try {
      final result = await Pokedex.fetchPokemon(query);

      setState(() {
        pokemon = result;
      });
    } catch (_) {
      setState(() {
        error = 'Pokemon not found';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    searchPokemon('pikachu');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const SideIndex(),
          const VerticalDivider(width: 1),
          Expanded(
            child: Column(
              children: [
                TopSearchBar(onSearch: searchPokemon),
                const Divider(height: 1),
                InformationSection(
                  pokemon: pokemon,
                  isLoading: isLoading,
                  error: error,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
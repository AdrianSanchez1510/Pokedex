import 'package:flutter/material.dart';
import '../widgets/index.dart';
import '../widgets/searchbar.dart';
import '../widgets/info.dart';
import '../services/pokedex.dart';

import '../models/pokemon.dart';
import '../models/pokemonSumm.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Pokemon? pokemon;

  List<PokemonSummary> allPokemon = [];
  List<PokemonSummary> filteredPokemon = [];

  bool isLoadingPokemon = false;
  bool isLoadingList = false;
  String? error;

  @override
  void initState() {
    super.initState();
    loadPokemonList();
    searchPokemon('squirtle');
  }

  Future<void> loadPokemonList() async {
    setState(() {
      isLoadingList = true;
    });

    try {
      final list = await Pokedex.fetchPokemonList();

      if (!mounted) return;

      setState(() {
        allPokemon = list;
        filteredPokemon = list;
        isLoadingList = false;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        isLoadingList = false;
        filteredPokemon = [];
      });
    }
  }

  Future<void> updateListFromSearch(String query) async {
    setState(() {
      isLoadingList = true;
    });

    await Future.delayed(const Duration(milliseconds: 150));

    if (!mounted) return;

    final cleanQuery = query.toLowerCase().trim();

    final results = allPokemon.where((pokemon) {
      return pokemon.name.toLowerCase().contains(cleanQuery) ||
          pokemon.id.toString() == cleanQuery;
    }).toList();

    setState(() {
      filteredPokemon = results;
      isLoadingList = false;
    });

    if (results.isNotEmpty) {
      await searchPokemon(results.first.name);
    }
  }

  Future<void> searchPokemon(String query) async {
    setState(() {
      isLoadingPokemon = true;
      error = null;
      pokemon = null;
    });

    try {
      final result = await Pokedex.fetchPokemon(query);

      if (!mounted) return;

      setState(() {
        pokemon = result;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        error = 'Pokemon not found';
      });
    } finally {
      if (!mounted) return;

      setState(() {
        isLoadingPokemon = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideIndex(
            pokemonList: filteredPokemon,
            isLoading: isLoadingList,
            onPokemonSelected: searchPokemon,
          ),
          const VerticalDivider(width: 1),
          Expanded(
            child: Column(
              children: [
                TopSearchBar(
                  onSearch: updateListFromSearch,
                ),
                const Divider(height: 1),
                Expanded(
                  child: InformationSection(
                    pokemon: pokemon,
                    isLoading: isLoadingPokemon,
                    error: error,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
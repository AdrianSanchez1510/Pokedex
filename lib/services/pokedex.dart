import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/pokemon.dart';

class Pokedex {
  static Future<Pokemon> fetchPokemon(String nameOrId) async {
    final query = nameOrId.toLowerCase().trim();
    final url = Uri.parse('https://pokeapi.co/api/v2/pokemon/$query');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Pokemon.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Pokemon not found');
    }
  }
}
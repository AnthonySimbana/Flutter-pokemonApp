import 'package:flutter/material.dart';
import 'package:pokedex_mobile/providers/pokemon_provider.dart';
import 'package:pokedex_mobile/widgets/pokemon_list_items.dart';
import 'package:provider/provider.dart';

class PokemonList extends StatefulWidget {
  const PokemonList({super.key});

  @override
  State<PokemonList> createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PokemonProvider>(builder: (context, provider, child) {
      return PokemonListItems(
          pokemons: provider
              .pokemons); //Wiget que va a reenderizar el arreglo de pokemons
    });
  }
}

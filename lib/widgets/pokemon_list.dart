import 'package:flutter/material.dart';
import 'package:pokedex_mobile/providers/pokemon_provider.dart';
import 'package:pokedex_mobile/screens/pokemon_details.dart';
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
      return ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: GestureDetector(
              onTap: () => {
                /*Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PokemonDetailsScreen(),
                  ),
                ),
                */
                Navigator.pushNamed(context, PokemonDetailsScreen.routeName,
                    arguments: provider.pokemons[index].id)
              },
              child: Card(
                elevation: 10,
                child: ListTile(
                  leading: Hero(
                      tag: provider.pokemons[index].id,
                      child: Image.network(provider.pokemons[index].imageUrl)),
                  title: Text(
                    provider.pokemons[index].name,
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: provider.totalPokemons,
      );
    });
  }
}

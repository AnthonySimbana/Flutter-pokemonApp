//Este wifget es para reutilizar el diseño de la ista de los pokemons
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_mobile/widgets/pokemon_favorite.dart';

import '../dtos/pokemon_model.dart';
import '../screens/pokemon_details.dart';

class PokemonListItems extends StatefulWidget {
  final List<Pokemon> pokemons;
  const PokemonListItems({super.key, required this.pokemons});

  @override
  State<PokemonListItems> createState() => _PokemonListItemsState();
}

class _PokemonListItemsState extends State<PokemonListItems> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(3.0),
          child: GestureDetector(
            onTap: () => {
              Navigator.pushNamed(context, PokemonDetailsScreen.routeName,
                  arguments: widget.pokemons[index]
                      .id) //'widget' es para usar atributos de la clase
            },
            child: Card(
              elevation: 10,
              child: ListTile(
                leading: Hero(
                    tag: widget.pokemons[index].id,
                    child: Image.network(widget.pokemons[index].imageUrl)),
                title: Text(
                  widget.pokemons[index].name,
                ),
                trailing: PokemonFavorite(
                    id: widget.pokemons[index]
                        .id), //LLama a un widget reutilizable para lo de los favoritos
              ),
            ),
          ),
        );
      },
      itemCount: widget.pokemons.length,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pokedex_mobile/providers/pokemon_provider.dart';
import 'package:pokedex_mobile/widgets/pokemon_list.dart';
import 'package:provider/provider.dart';

class PokemonScreenWidget extends StatefulWidget {
  const PokemonScreenWidget({super.key});

  @override
  State<PokemonScreenWidget> createState() => _PokemonScreenWidgetState();
}

class _PokemonScreenWidgetState extends State<PokemonScreenWidget> {
  bool isSearch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              setState(() {
                isSearch = !isSearch;
              });
            },
            icon: const Icon(Icons.search))
      ], title: !isSearch ? const Text('Pokemons') : const Text('Search...')),
      body: FutureBuilder(
        future: Provider.of<PokemonProvider>(context, listen: false)
            .checkPokemons(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //Cuando la llamada al metodo async se ejecuta
            return const PokemonList();
          } else {
            //cuando la llamada el metodo async se inicia (en proceso)
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

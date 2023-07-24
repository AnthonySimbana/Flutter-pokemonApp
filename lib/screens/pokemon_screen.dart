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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemons'),
      ),
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pokemon_provider.dart';

class PokemonFavorite extends StatefulWidget {
  final int id;

  const PokemonFavorite(
      {super.key,
      required this.id}); //El ID es necesario por eso se lo coloca como atributo

  @override
  State<PokemonFavorite> createState() => _PokemonFavoriteState();
}

class _PokemonFavoriteState extends State<PokemonFavorite> {
  //ESTO ES MAS EFICIENTE, CANAL BIDIRECCIONAL
  late Stream<DocumentSnapshot>
      _documentStream; //Esto simula un realtime con la base de datos fireestore

  @override
  void initState() {
    var db = FirebaseFirestore.instance;
    _documentStream =
        db.collection('pokemons').doc(widget.id.toString()).snapshots();
    super.initState();
  }

  _markFavoriteStatus(int id, bool value) {
    //Es un metodo privado
    Provider.of<PokemonProvider>(context, listen: false)
        .updatePokemonFavoriteStatus(id, value);
  }

  //Crea un widget acorde al valor isFavorite para retornar un boton favorito
  Widget renderFavoriteIcon(bool state) {
    if (state) {
      return IconButton(
        onPressed: () => _markFavoriteStatus(widget.id, false),
        icon: const Icon(Icons.favorite),
      );
    } else {
      return IconButton(
        onPressed: () => _markFavoriteStatus(widget.id, true),
        icon: const Icon(Icons.favorite_border),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _documentStream,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          var data = snapshot.data!;
          print('data: ${data["name"].toString()}');

          /* Verificar si tiene Favorito, si es true, pintar icono A, caso contrario pintar B */

          bool flagFavorite = false;
          try {
            if (data["isFavorite"] == true) {
              flagFavorite = true;
            }
          } on StateError {
            print('state error');
          }

          return renderFavoriteIcon(flagFavorite);
        });

    /*
     IconButton(
      onPressed: () => _markFavoriteStatus(widget.id, true),
      icon: const Icon(Icons.favorite_border),
    );
    */
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_mobile/dtos/pokemon_model.dart';
import 'package:pokedex_mobile/widgets/pokemon_list_items.dart';
import 'package:provider/provider.dart';

class PokemonFavoriteListScreen extends StatefulWidget {
  const PokemonFavoriteListScreen({super.key});

  @override
  State<PokemonFavoriteListScreen> createState() =>
      _PokemonFavoriteListScreenState();
}

class _PokemonFavoriteListScreenState extends State<PokemonFavoriteListScreen> {
  late Stream<QuerySnapshot>
      _queryStream; //Aqui el snapshot para consuutar a un campo interno de un documento, puede retornar uno o VARIOS documentos
  //Aqui recibe notificaciones un REALTIME y actualiza la app
  @override
  void initState() {
    var db = FirebaseFirestore.instance;
    _queryStream = db
        .collection('pokemons')
        .where('isFavorite', isEqualTo: true)
        .withConverter<Pokemon>(
            //Aqui hace la llamada de conversion de documentos a un tipo de dato
            fromFirestore: (snapshot, _) =>
                Pokemon.fromFirebaseJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson())
        .snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pokemons Favoritos'),
        ),
        body: StreamBuilder(
            stream: _queryStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              //Transforma los datos de la consulta del query en pokemons
              List<Pokemon> pokemons =
                  snapshot.data!.docs.map((e) => e.data() as Pokemon).toList();
              //docs lista de elementos asociados al query
              return PokemonListItems(pokemons: pokemons);
            }));
  }
}

/*SnapShot tiene
      Data
        docs() -> Arreglo 
          maps (-> doc -data -> Pokemon)
            toList()

*/

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class PokemonProvider extends ChangeNotifier {
  final List<String> _pokemon = [];

  Future<void> initPokemonList() async {
    var client = http.Client();
    var response = await client.get(Uri.http('pokeapi.co', '/api/v2/pokemon'));
    print('statusPokemon: ${response.statusCode}'); //codigo de retorno HTTP
    print('pokemon List: ${response.body}');
  }
}

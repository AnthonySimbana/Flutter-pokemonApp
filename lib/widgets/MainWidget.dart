import 'package:flutter/material.dart';

import '../screens/category_screen.dart';
import '../screens/pokemon_favorite_list.dart';
import '../screens/pokemon_screen.dart';

class MainWidget extends StatefulWidget {
  static const routeName = '/';

  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

//Aqui se definen las pantallas existentes
class _MainWidgetState extends State<MainWidget> {
  int _selectedIndex = 0;
  bool _isUserAuthenticated = false; // Agrega esta variable

  final List<Widget> _mainWidgets = const [
    CategoryScreen(),
    PokemonScreenWidget(),
    PokemonFavoriteListScreen()
  ];

  void _onTapItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //Esto controa la barra de navegacion inferior, en orden de los elemntos se va creando los iconos para navegar entre pantallas
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _mainWidgets[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categorias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.details),
            label: 'Pokemons',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favoritos',
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onTapItem,
      ),
    );
  }
}

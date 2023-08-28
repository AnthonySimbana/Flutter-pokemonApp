import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_mobile/providers/category_provider.dart';
import 'package:pokedex_mobile/providers/pokemon_provider.dart';
import 'package:pokedex_mobile/screens/pokemon_details.dart';
import 'package:pokedex_mobile/widgets/MainWidget.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:pokedex_mobile/screens/signin_screen.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //Para inicializar instancias primero como firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => CategoryProvider()),
          ChangeNotifierProvider(create: (context) => PokemonProvider()),
        ],
        child: MaterialApp(
          title: 'Pokedex',
          //initialRoute: MainWidget.routeName,
          initialRoute: '/',
          routes: {
            '/': (context) => const SignInScreen(),
            //MainWidget.routeName: (context) => const MainWidget(),
            PokemonDetailsScreen.routeName: (context) =>
                const PokemonDetailsScreen()
          },
        ));
  }
}

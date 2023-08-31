import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_mobile/providers/category_provider.dart';
import 'package:pokedex_mobile/providers/pokemon_provider.dart';
import 'package:pokedex_mobile/screens/category_screen.dart';
import 'package:pokedex_mobile/screens/pokemon_details.dart';
import 'package:pokedex_mobile/widgets/mainWidget.dart';
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
        home: const AuthenticationWrapper(),
        //initialRoute: '/',
        /*
        onGenerateRoute: (settings) {
          if (settings.name == PokemonDetailsScreen.routeName) {
            // Obtener el argumento pasado a la ruta
            //final String pokemonId = settings.arguments as String;
            return MaterialPageRoute(
              builder: (context) => const PokemonDetailsScreen(),
            );
          }
          return null;
        },
        */
        routes: {
          MainWidget.routeName: (context) => const MainWidget(),
          // MainWidget.routeName ya no se usa aquí
          PokemonDetailsScreen.routeName: (context) =>
              const PokemonDetailsScreen()
        },
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // Verificar el estado de autenticación aquí (puedes usar Firebase Auth o cualquier otro método)
    // Si el usuario está autenticado, regresa MainWidget
    // Si el usuario no está autenticado, regresa SignInScreen
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;

    if (user != null) {
      // Si el usuario está autenticado, regresa MainWidget
      return const MainWidget();
    } else {
      // Si el usuario no está autenticado, regresa SignInScreen
      return const SignInScreen();
    }
  }
}

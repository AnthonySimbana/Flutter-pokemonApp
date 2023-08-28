import 'package:firebase_auth/firebase_auth.dart';
import 'package:pokedex_mobile/widgets/reusable_widget.dart';
import 'package:pokedex_mobile/widgets/MainWidget.dart';
import 'package:pokedex_mobile/utils/color_utils.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController _emailTextController = TextEditingController();
  String _errorMessage = ""; // Variable para mostrar mensajes de error

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("0ab4e4"),
              hexStringToColor("130d90"),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const Text(
                  "Cambiar contraseña",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  "Ingrese el correo electrónico que tiene asociado a su cuenta",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 20),
                reusableTextField(
                  "correo@ejemplo.com",
                  Icons.person_outline,
                  false,
                  _emailTextController,
                ),
                const SizedBox(height: 20),
                Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
                firebaseUIButton(context, "Cambiar contraseña", () {
                  if (_emailTextController.text.isEmpty) {
                    setState(() {
                      _errorMessage =
                          "Por favor, ingrese su correo electrónico.";
                    });
                    return;
                  }

                  FirebaseAuth.instance
                      .sendPasswordResetEmail(email: _emailTextController.text)
                      .then((value) {
                    // Resetear el mensaje de error si la operación fue exitosa
                    setState(() {
                      _errorMessage = "";
                    });
                    Navigator.of(context).pop();
                  }).catchError((error) {
                    setState(() {
                      _errorMessage = "Error: $error";
                    });
                  });
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

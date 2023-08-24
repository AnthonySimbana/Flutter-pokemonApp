import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_mobile/providers/pokemon_provider.dart';
import 'package:provider/provider.dart';

class InputComment extends StatefulWidget {
  final int id;
  const InputComment({super.key, required this.id});

  @override
  State<InputComment> createState() => _InputCommentState();
}

class _InputCommentState extends State<InputComment> {
  final _formKey = GlobalKey<FormState>(); //Para identifcar a clase

  final _myController =
      TextEditingController(); //Para almacenar los comentarios

  late FocusNode _textFocus;

  //Cada que ingreso el texto, la app esche el texto que ingreso
  _printText() {
    print('El texto del input es: ${_myController}');
  }

  @override
  void initState() {
    _myController.addListener(_printText);
    _textFocus = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(
                  8.0), //Para darle padding (separacion al texto)
              child: TextFormField(
                autofocus: true, //Le da foco/atencion sobre lo que debe hacer
                //Aqui esta el input de entrada de texto
                decoration: const InputDecoration(
                    //Con esto decoro e cuadro de texto
                    prefixIcon: Icon(Icons.comment),
                    //suffixIcon: Icon(Icons.close),
                    hintText: 'Ingrese un comentario',
                    labelText: 'Comentario'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El comentario es requerido';
                  }
                  return null;
                },
                controller: _myController,
                focusNode: _textFocus,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      if (_formKey
                          .currentState! //Esto hace de Nullable - No-nullable
                          .validate()) //Con esto verifico el estado de mi formulario
                      {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          /*
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {},
                          ),*/
                          content: Text('Agregando comentario'),
                        ));
                        print(
                            'el valor de comentario del pokemon id:${widget.id} y el text: ${_myController.text}');

                        Provider.of<PokemonProvider>(context, listen: false)
                            .addCommentToPokemonDoc(
                                widget.id, _myController.text);

                        _myController.text = '';
                      }
                    },
                    child: const Text('Sumbit')),
                OutlinedButton(
                    onPressed: () {
                      _textFocus.requestFocus();
                    },
                    child: const Text('Set Focus')),
              ],
            ),
          ],
        ));
  }
}

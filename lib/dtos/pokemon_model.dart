class Pokemon {
  int id;
  String name;
  String imageUrl;

  Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      imageUrl: json['sprites']['front_default'],
    );
  }

  //Estos metodos para convertir los documentos en un dato de tipo específico en el modelo
  //El withConverter se lo hace en la llamada

//Esto para convertir lo que viene de Firebase a Pokemon
  factory Pokemon.fromFirebaseJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }

//Otra manera de expresar un return de manera abreviada con el () =>
//Para convertir a Objeto lo que tiene el Pokemon
  Map<String, Object?> toJson() => {
        'id': id,
        'name': name,
        'imageUrl': imageUrl,
      };
}

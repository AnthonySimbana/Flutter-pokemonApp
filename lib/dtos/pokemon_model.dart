import 'package:flutter/material.dart';

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
}

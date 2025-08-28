

import 'package:test_tik_tok_cat/Data/Model/CatBreed.dart';

class CatImage {
  final String id;
  final String url;
  final CatBreed? breed; // La información de la raza puede ser nula

  CatImage({
    required this.id,
    required this.url,
    this.breed,
  });

  // Factory constructor para crear una instancia de CatImage desde un mapa JSON
  factory CatImage.fromJson(Map<String, dynamic> json) {
    // La API devuelve la información de la raza dentro de una lista anidada.
    // Verificamos si la lista 'breeds' existe y no está vacía.
    final breedData = json['breeds'] != null && (json['breeds'] as List).isNotEmpty
        ? CatBreed.fromJson(json['breeds'][0])
        : null;

    return CatImage(
      id: json['id'],
      url: json['url'],
      breed: breedData,
    );
  }
}
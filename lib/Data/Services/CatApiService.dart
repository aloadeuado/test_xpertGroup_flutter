import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_tik_tok_cat/Data/Model/CatBreed.dart';
import 'package:test_tik_tok_cat/Data/Model/CatImage.dart';

class CatApiService {
  final String _apiKey = 'live_JBT0Ah0Nt12iyl2IpjQVLDWjcLk0GQwf4zI9wBMfmfejKmcC31mOJp4yJz5TsOUP';
  final String _baseUrl = 'https://api.thecatapi.com/v1';

  Future<List<CatBreed>> getBreeds() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/breeds'),
      headers: {'x-api-key': _apiKey},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => CatBreed.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load cat breeds');
    }
  }

  Future<List<CatImage>> getImagesByBreed(String breedId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/images/search?limit=10&breed_ids=$breedId'),
      headers: {'x-api-key': _apiKey},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      // Importante: La info de la raza viene anidada en la primera imagen
      final breedInfo = data.isNotEmpty && data[0]['breeds'].isNotEmpty
          ? CatBreed.fromJson(data[0]['breeds'][0])
          : null;

      return data.map((json) => CatImage.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load cat images');
    }
  }
}
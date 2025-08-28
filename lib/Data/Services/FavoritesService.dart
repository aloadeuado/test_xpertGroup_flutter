import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_tik_tok_cat/Data/Model/CatImage.dart';

class FavoritesService {
  static const _key = 'favorite_cats';

  Future<List<CatImage>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> favoritesJson = prefs.getStringList(_key) ?? [];
    return favoritesJson
        .map((jsonString) => CatImage.fromJson(json.decode(jsonString)))
        .toList();
  }

  Future<void> saveFavorites(List<CatImage> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> favoritesJson = favorites
        .map((cat) => json.encode({
      'id': cat.id,
      'url': cat.url,
      'breeds': cat.breed != null ? [
        {
          'id': cat.breed!.id,
          'name': cat.breed!.name,
          'origin': cat.breed!.origin,
          'description': cat.breed!.description,
          'life_span': cat.breed!.lifeSpan,
          'intelligence': cat.breed!.intelligence,
          'wikipedia_url': cat.breed!.wikipediaUrl,
        }
      ] : []
    }))
        .toList();
    await prefs.setStringList(_key, favoritesJson);
  }
}
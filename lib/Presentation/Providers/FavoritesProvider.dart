import 'package:flutter/material.dart';
import 'package:test_tik_tok_cat/Data/Model/CatImage.dart';
import 'package:test_tik_tok_cat/Data/Services/FavoritesService.dart';

class FavoritesProvider extends ChangeNotifier {
  final FavoritesService _favoritesService;
  List<CatImage> _favorites = [];

  FavoritesProvider(this._favoritesService) {
    loadFavorites();
  }

  List<CatImage> get favorites => _favorites;

  Future<void> loadFavorites() async {
    _favorites = await _favoritesService.getFavorites();
    notifyListeners();
  }

  bool isFavorite(CatImage cat) {
    return _favorites.any((fav) => fav.id == cat.id);
  }

  void toggleFavorite(CatImage cat) {
    if (isFavorite(cat)) {
      _favorites.removeWhere((fav) => fav.id == cat.id);
    } else {
      _favorites.add(cat);
    }
    _favoritesService.saveFavorites(_favorites);
    notifyListeners();
  }
}
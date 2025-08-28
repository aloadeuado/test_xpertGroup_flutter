import 'package:flutter/material.dart';
import 'package:test_tik_tok_cat/Data/Model/CatBreed.dart';
import 'package:test_tik_tok_cat/Data/Model/CatImage.dart';
import 'package:test_tik_tok_cat/Data/Services/CatApiService.dart';

class HomeProvider extends ChangeNotifier {
  final CatApiService _apiService;

  HomeProvider(this._apiService) {
    fetchBreeds();
  }

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<CatBreed> _breeds = [];
  List<CatBreed> get breeds => _breeds;

  List<CatImage> _images = [];
  List<CatImage> get images => _images;

  CatBreed? _selectedBreed;
  CatBreed? get selectedBreed => _selectedBreed;

  Future<void> fetchBreeds() async {
    _isLoading = true;
    notifyListeners();
    try {
      _breeds = await _apiService.getBreeds();
      // Si hay razas, carga las imágenes de la primera por defecto
      if (_breeds.isNotEmpty) {
        await fetchImagesByBreed(_breeds.first.id);
      }
    } catch (e) {
      // Manejar error
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchImagesByBreed(String breedId) async {
    _isLoading = true;
    notifyListeners();
    try {
      _images = await _apiService.getImagesByBreed(breedId);
      _selectedBreed = _images.isNotEmpty ? _images.first.breed : null;
    } catch (e) {
      // Manejar error
    }
    _isLoading = false;
    notifyListeners();
  }
}
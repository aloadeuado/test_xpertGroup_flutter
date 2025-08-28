

// Enum para el modo de visualización de la imagen
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ImageViewMode { cover, containWithBlur }

class SettingsProvider extends ChangeNotifier {
  late SharedPreferences _prefs;

  // --- Propiedades con valores por defecto ---
  double _imageLimit = 10.0;
  double get imageLimit => _imageLimit;

  ImageViewMode _viewMode = ImageViewMode.cover;
  ImageViewMode get viewMode => _viewMode;

  // --- Constructor e inicialización ---
  SettingsProvider() {
    _loadSettings();
  }

  // Carga las preferencias guardadas al iniciar la app
  Future<void> _loadSettings() async {
    _prefs = await SharedPreferences.getInstance();
    _imageLimit = _prefs.getDouble('imageLimit') ?? 10.0;
    int viewModeIndex = _prefs.getInt('viewMode') ?? 0;
    _viewMode = ImageViewMode.values[viewModeIndex];
    notifyListeners();
  }

  // --- Métodos para actualizar y guardar las preferencias ---
  void updateImageLimit(double newLimit) {
    _imageLimit = newLimit;
    _prefs.setDouble('imageLimit', newLimit);
    notifyListeners();
  }

  void updateImageViewMode(ImageViewMode newMode) {
    _viewMode = newMode;
    _prefs.setInt('viewMode', newMode.index);
    notifyListeners();
  }
}
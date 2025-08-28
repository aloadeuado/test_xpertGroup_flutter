import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_tik_tok_cat/Presentation/Providers/HomeProvider.dart';
import 'package:test_tik_tok_cat/Presentation/Providers/SettingsProvider.dart';

class SettingsPopover extends StatefulWidget {
  const SettingsPopover({super.key});

  // Método estático para mostrar el diálogo
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const SettingsPopover(),
    );
  }

  @override
  State<SettingsPopover> createState() => _SettingsPopoverState();
}

class _SettingsPopoverState extends State<SettingsPopover> {
  late double _currentLimit;
  late ImageViewMode _currentViewMode;

  @override
  void initState() {
    super.initState();
    // Inicializa el estado local con los valores actuales del provider
    final settings = Provider.of<SettingsProvider>(context, listen: false);
    _currentLimit = settings.imageLimit;
    _currentViewMode = settings.viewMode;
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context, listen: false);

    return AlertDialog(
      backgroundColor: const Color(0xFF1C1C1C),
      title: const Text('Ajustes'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Slider para el límite de imágenes ---
            Text('Imágenes por raza: ${_currentLimit.toInt()}'),
            Slider(
              value: _currentLimit,
              min: 10,
              max: 100, // La API solo permite hasta 100
              divisions: 9, // (100-10)/10
              label: _currentLimit.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _currentLimit = value;
                });
              },
            ),
            const SizedBox(height: 20),
            // --- Switch para el modo de visualización ---
            const Text('Modo de Visualización'),
            ListTile(
              title: const Text('Pantalla Completa'),
              leading: Radio<ImageViewMode>(
                value: ImageViewMode.cover,
                groupValue: _currentViewMode,
                onChanged: (value) {
                  setState(() {
                    _currentViewMode = value!;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Centrado con Fondo Blur'),
              leading: Radio<ImageViewMode>(
                value: ImageViewMode.containWithBlur,
                groupValue: _currentViewMode,
                onChanged: (value) {
                  setState(() {
                    _currentViewMode = value!;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: const Text('Guardar'),
          onPressed: () {
            // Actualiza los valores en el provider al guardar
            settingsProvider.updateImageLimit(_currentLimit);
            settingsProvider.updateImageViewMode(_currentViewMode);
            Navigator.of(context).pop();
            // Opcional: Refrescar las imágenes automáticamente
            Provider.of<HomeProvider>(context, listen: false)
                .fetchImagesByBreed(Provider.of<HomeProvider>(context, listen: false).selectedBreed!.id);
          },
        ),
      ],
    );
  }
}
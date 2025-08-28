import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:test_tik_tok_cat/Data/Model/CatImage.dart';
import 'package:test_tik_tok_cat/Presentation/Providers/FavoritesProvider.dart';
import 'package:test_tik_tok_cat/Presentation/Providers/SettingsProvider.dart';


class CardCatWidget extends StatelessWidget {
  final CatImage catImage;

  // Eliminamos el parámetro isContain, ahora lo leeremos del SettingsProvider
  const CardCatWidget({super.key, required this.catImage});

  @override
  Widget build(BuildContext context) {
    // Leemos los providers necesarios. listen: true para que se redibuje si cambian.
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    // Determinamos el modo de vista y si la imagen actual es favorita
    final viewMode = settingsProvider.viewMode;
    final bool isFav = favoritesProvider.isFavorite(catImage);

    return Stack(
      fit: StackFit.expand,
      children: [
        // --- FONDO DE LA TARJETA (Dinámico según el modo de vista) ---
        _buildBackgroundImage(viewMode),

        // --- INFORMACIÓN SUPERPUESTA (Textos, tags, etc.) ---
        _buildInfoOverlay(context),

        // --- ICONO DE CORAZÓN PARA FAVORITOS ---
        Positioned(
          right: 16,
          bottom: 150, // Ajusta esta posición para que quede sobre los textos
          child: GestureDetector(
            onTap: () {
              // Al tocar, llamamos al método del provider para añadir/quitar de favoritos
              // Usamos listen: false porque solo estamos ejecutando una acción, no redibujando.
              Provider.of<FavoritesProvider>(context, listen: false)
                  .toggleFavorite(catImage);
            },
            child: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: isFav ? Colors.redAccent : Colors.white,
              size: 40,
              shadows: const [
                Shadow(blurRadius: 8, color: Colors.black54),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Widget helper para construir el fondo según el modo de vista
  Widget _buildBackgroundImage(ImageViewMode viewMode) {
    if (viewMode == ImageViewMode.containWithBlur) {
      return Stack(
        fit: StackFit.expand,
        children: [
          // Imagen de fondo con blur
          CachedNetworkImage(
            imageUrl: catImage.url,
            fit: BoxFit.cover,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(color: Colors.black.withOpacity(0.3)),
          ),
          // Imagen principal contenida
          CachedNetworkImage(
            imageUrl: catImage.url,
            fit: BoxFit.contain,
            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ],
      );
    } else {
      // Vista normal en modo cover
      return CachedNetworkImage(
        imageUrl: catImage.url,
        fit: BoxFit.cover,
        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    }
  }

  // Widget helper para la información del gato (tu código anterior mejorado)
  Widget _buildInfoOverlay(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.6, 1.0],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            catImage.breed?.name ?? 'Unknown Breed',
            style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(blurRadius: 2, color: Colors.black)]),
          ),
          const SizedBox(height: 4),
          Text(
            catImage.breed?.description ?? 'No description available.',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                shadows: [Shadow(blurRadius: 2, color: Colors.black)]),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: [
              if (catImage.breed?.origin != null)
                _buildInfoTag(catImage.breed!.origin),
              if (catImage.breed?.lifeSpan != null)
                _buildInfoTag("Life: ${catImage.breed!.lifeSpan} years"),
              if (catImage.breed?.intelligence != null)
                _buildInfoTag("Intelligence: ${catImage.breed!.intelligence}/5"),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildInfoTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.white.withOpacity(0.85),
      ),
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}
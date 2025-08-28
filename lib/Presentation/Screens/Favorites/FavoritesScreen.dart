import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_tik_tok_cat/Presentation/Providers/FavoritesProvider.dart';
import 'package:test_tik_tok_cat/Presentation/Providers/SettingsProvider.dart';
import '../../widgets/CardCatWidget.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Favoritos'),
      ),
      body: Consumer2<FavoritesProvider, SettingsProvider>(
        builder: (context, favoritesProvider, settingsProvider, child) {
          if (favoritesProvider.favorites.isEmpty) {
            return const Center(
              child: Text(
                'Aún no tienes gatos favoritos.',
                style: TextStyle(color: Colors.white70),
              ),
            );
          }

          return PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: favoritesProvider.favorites.length,
            itemBuilder: (context, index) {
              final catImage = favoritesProvider.favorites[index];
              return CardCatWidget(
                catImage: catImage,
              );
            },
          );
        },
      ),
    );
  }
}
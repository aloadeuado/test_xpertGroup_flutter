import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:test_tik_tok_cat/Presentation/Providers/HomeProvider.dart';
import 'package:test_tik_tok_cat/Presentation/Widgets/CardCatWidget.dart';

// Importa tu widget CatCard personalizado aquí

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Escucha al provider para obtener los datos y redibujar cuando cambien
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: provider.isLoading
                ? const Text("Cargando razas...")
                : DropdownButton<String>(
              isExpanded: true,
              value: provider.selectedBreed?.id,
              hint: const Text("Selecciona una raza"),
              dropdownColor: Colors.black,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  provider.fetchImagesByBreed(newValue);
                }
              },
              items: provider.breeds.map<DropdownMenuItem<String>>((breed) {
                return DropdownMenuItem<String>(
                  value: breed.id,
                  child: Text(breed.name),
                );
              }).toList(),
            ),
          ),
          body: provider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: provider.images.length,
            itemBuilder: (context, index) {
              final catImage = provider.images[index];

              return CardCatWidget(catImage: catImage,);
            },
          ),
        );
      },
    );
  }
}
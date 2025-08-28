import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_tik_tok_cat/Data/Model/CatBreed.dart';
import 'package:test_tik_tok_cat/Data/Model/CatImage.dart';

class CardCatWidget extends StatelessWidget{
  final CatImage catImage;
  bool isContain;


  CardCatWidget({required this.catImage, this.isContain  = false});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      fit: StackFit.expand,
      children: [
        CachedNetworkImage(
          imageUrl: catImage.url,
          fit: isContain ? BoxFit.contain : BoxFit.cover,
          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        // Aquí pondrías el resto de la info sobre la imagen
        Container(
          margin: EdgeInsets.only(
              bottom: 12,
              left: 16,
              right: 16
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                catImage.breed?.name ?? 'Sin nombre',
                style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, backgroundColor: Colors.black54),
              ),
              SizedBox(height: 2,),
              Text(
                catImage.breed?.description ?? 'Sin descripcion',
                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold, backgroundColor: Colors.black54),
              ),
              SizedBox(height: 3,),
              Container(
                padding: EdgeInsets.only(
                    left: 10,
                    right: 10
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white
                ),
                child: Text(
                  catImage.breed?.origin ?? 'Sin descripcion',
                  style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 8,),
              Container(
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: 10,
                          right: 10
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white
                      ),
                      child: Text(
                        "Life Span: ${catImage.breed?.lifeSpan} (y)"  ?? 'Sin descripcion',
                        style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 5,),
                    Container(
                      padding: EdgeInsets.only(
                          left: 10,
                          right: 10
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white
                      ),
                      child: Text(
                        "Intelligence: ${catImage.breed?.intelligence}"  ?? 'Sin descripcion',
                        style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )

      ],
    );
  }

}
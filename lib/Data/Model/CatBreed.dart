class CatBreed {
  final String id;
  final String name;
  final String origin;
  final String description;
  final String lifeSpan;
  final int intelligence;
  final String? wikipediaUrl;

  CatBreed({
    required this.id,
    required this.name,
    required this.origin,
    required this.description,
    required this.lifeSpan,
    required this.intelligence,
    this.wikipediaUrl,
  });

  factory CatBreed.fromJson(Map<String, dynamic> json) {
    return CatBreed(
      id: json['id'],
      name: json['name'],
      origin: json['origin'],
      description: json['description'],
      lifeSpan: json['life_span'],
      intelligence: json['intelligence'],
      wikipediaUrl: json['wikipedia_url'],
    );
  }
}
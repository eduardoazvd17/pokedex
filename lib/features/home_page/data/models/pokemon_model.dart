class PokemonModel {
  final String name;
  final String url;

  PokemonModel({
    required this.url,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'name': name,
    };
  }

  factory PokemonModel.fromMap(Map<String, dynamic> map) {
    return PokemonModel(
      name: map['name'],
      url: map['url'],
    );
  }
}

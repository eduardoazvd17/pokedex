import 'package:hive/hive.dart';
import '../../enums/pokemon_type.dart';
import '../pokemon_model.dart';

class PokemonModelAdapter extends TypeAdapter<PokemonModel> {
  @override
  int get typeId => 1; // Escolha um número exclusivo para seu TypeAdapter

  @override
  PokemonModel read(BinaryReader reader) {
    return PokemonModel(
      id: reader.read(),
      order: reader.read(),
      name: reader.read(),
      types: List<String>.from(reader.read()).map((e) {
        return PokemonTypeExtension.fromName(e);
      }).toList(),
      imageUrl: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, PokemonModel obj) {
    writer.write(obj.id);
    writer.write(obj.order);
    writer.write(obj.name);
    writer.write(obj.types.map((e) => e.name).toList());
    writer.write(obj.imageUrl);
  }
}

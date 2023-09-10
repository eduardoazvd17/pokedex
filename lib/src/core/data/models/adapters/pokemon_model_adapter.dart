import 'package:hive/hive.dart';
import '../../enums/pokemon_type.dart';
import '../pokemon_model.dart';

class PokemonModelAdapter extends TypeAdapter<PokemonModel> {
  @override
  int get typeId => 1; // Escolha um número exclusivo para seu TypeAdapter

  @override
  PokemonModel read(BinaryReader reader) {
    return PokemonModel(
      order: reader.readInt(),
      name: reader.readString(),
      types: reader.readList().map((e) {
        return PokemonTypeExtension.fromName(e as String);
      }).toList(),
      imageUrl: reader.readString(),
      height: reader.readDouble(),
      weight: reader.readDouble(),
      gender: reader.readString(),
      abilities: List<String>.from(reader.readList()),
    );
  }

  @override
  void write(BinaryWriter writer, PokemonModel obj) {
    writer.writeInt(obj.order);
    writer.writeString(obj.name);
    writer.writeList(obj.types.map((e) => e.name).toList());
    writer.writeString(obj.imageUrl);
    writer.writeDouble(obj.height);
    writer.writeDouble(obj.weight);
    writer.writeString(obj.gender);
    writer.writeList(obj.abilities);
  }
}

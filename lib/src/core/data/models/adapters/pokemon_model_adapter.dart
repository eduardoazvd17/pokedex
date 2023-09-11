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
    );
  }

  @override
  void write(BinaryWriter writer, PokemonModel obj) {
    writer.writeInt(obj.order);
    writer.writeString(obj.name);
    writer.writeList(obj.types.map((e) => e.name).toList());
    writer.writeString(obj.imageUrl);
  }
}

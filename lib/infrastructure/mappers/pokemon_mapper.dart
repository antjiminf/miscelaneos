import 'package:miscelaneos/domain/domain.dart';
import 'package:miscelaneos/infrastructure/infrastructure.dart';

class PokemonMapper {
  static Pokemon pokeApiPokemonToEntity(Map<String, dynamic> json) {
    final pokemonResponse = PokemonApiResponse.fromJson(json);

    return Pokemon(
      id: pokemonResponse.id,
      name: pokemonResponse.name,
      spriteFront: pokemonResponse.sprites.frontDefault,
    );
  }
}

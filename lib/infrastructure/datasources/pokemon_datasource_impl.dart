import 'package:dio/dio.dart';
import 'package:miscelaneos/domain/domain.dart';
import 'package:miscelaneos/infrastructure/infrastructure.dart';

class PokemonDatasourceImpl implements PokemonDatasource {
  final Dio dio;

  PokemonDatasourceImpl()
    : dio = Dio(BaseOptions(baseUrl: 'https://pokeapi.co/api/v2/'));

  @override
  Future<(Pokemon?, String)> getPokemon(String id) async {
    try {
      final response = await dio.get('/pokemon/$id');
      final pokemon = PokemonMapper.pokeApiPokemonToEntity(response.data);
      return (pokemon, 'Pokemon encontrado!');
    } catch (e) {
      return (null, 'No se pudo obtener el pokemon $e');
    }
  }
}

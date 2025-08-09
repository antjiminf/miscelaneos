import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/domain/domain.dart';
import 'package:miscelaneos/infrastructure/infrastructure.dart';

final pokemonsRepositoryProvider = Provider<PokemonRepository>((ref) {
  return PokemonRepositoryImpl();
});

final pokemonProvider = FutureProvider.family<Pokemon, String>((ref, id) async {
  final repository = ref.watch(pokemonsRepositoryProvider);
  final (pokemon, error) = await repository.getPokemon(id);

  if (pokemon != null) return pokemon;

  throw error;
});

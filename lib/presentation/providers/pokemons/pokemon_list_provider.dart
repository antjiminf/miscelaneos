import 'package:flutter_riverpod/flutter_riverpod.dart';

final pokemonListProvider = StateProvider<List<int>>((ref) {
  return List.generate(100, (i) => i + 1);
});

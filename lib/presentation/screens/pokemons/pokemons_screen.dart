import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class PokemonsScreen extends StatelessWidget {
  const PokemonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: PokemonsView());
  }
}

class PokemonsView extends ConsumerStatefulWidget {
  const PokemonsView({super.key});

  @override
  ConsumerState<PokemonsView> createState() => _PokemonsViewState();
}

class _PokemonsViewState extends ConsumerState<PokemonsView> {
  final scrollController = ScrollController();

  void infiniteScroll() {
    final pokemons = ref.read(pokemonListProvider);

    if (pokemons.length > 400) {
      scrollController.removeListener(infiniteScroll);
      return;
    }

    if ((scrollController.position.pixels + 200) >
        scrollController.position.maxScrollExtent) {
      ref
          .read(pokemonListProvider.notifier)
          .update(
            (state) => [
              ...state,
              ...List.generate(30, (index) => state.length + index + 1),
            ],
          );
    }
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(infiniteScroll);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverAppBar(
          title: const Text('Pokemons List'),
          floating: true,
          backgroundColor: Colors.white.withValues(alpha: 0.8),
        ),

        _PokemonGrid(),
      ],
    );
  }
}

class _PokemonGrid extends ConsumerWidget {
  const _PokemonGrid();

  @override
  Widget build(BuildContext context, ref) {
    final pokemonIds = ref.watch(pokemonListProvider);
    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: pokemonIds.length,
      itemBuilder: (context, index) {
        final id = pokemonIds[index];
        return GestureDetector(
          onTap: () => context.push('/pokemons/$id'),
          child: Image.network(
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png',
          ),
        );
      },
    );
  }
}

import 'package:go_router/go_router.dart';
import 'package:miscelaneos/presentation/screens/screens.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => HomeScreen()),
    GoRoute(
      path: '/permissions',
      builder: (context, state) => PermissionsScreen(),
    ),
    GoRoute(path: '/gyroscope', builder: (context, state) => GyroscopeScreen()),
    GoRoute(
      path: '/gyroscope-ball',
      builder: (context, state) => GyroscopeBallScreen(),
    ),
    GoRoute(
      path: '/accelerometer',
      builder: (context, state) => AccelerometerScreen(),
    ),
    GoRoute(
      path: '/magnetometer',
      builder: (context, state) => MagnetometerScreen(),
    ),
    GoRoute(path: '/compass', builder: (context, state) => CompassScreen()),
    GoRoute(
      path: '/pokemons',
      builder: (context, state) => PokemonsScreen(),
      routes: [
        GoRoute(
          path: ':id',
          builder: (context, state) {
            final id = state.pathParameters['id'] ?? '1';
            return PokemonScreen(pokemonId: id);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/biometrics',
      builder: (context, state) => BiometricScreen(),
    ),
    GoRoute(path: '/location', builder: (context, state) => LocationScreen()),
    GoRoute(path: '/map', builder: (context, state) => MapScreen()),
    GoRoute(
      path: '/controlled-map',
      builder: (context, state) => ControlledMapScreen(),
    ),
  ],
);

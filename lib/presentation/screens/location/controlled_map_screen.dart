import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class ControlledMapScreen extends ConsumerWidget {
  const ControlledMapScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final userInitialLocation = ref.watch(userLocationProvider);

    return Scaffold(
      body: userInitialLocation.when(
        data: (data) => MapAndControls(latitude: data.$1, longitude: data.$2),
        error: (error, stackTrace) => Center(child: Text('$error')),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class MapAndControls extends ConsumerWidget {
  final double latitude;
  final double longitude;

  const MapAndControls({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context, ref) {
    final mapController = ref.watch(mapControllerProvider);

    return Stack(
      children: [
        _MapView(initialLatitude: latitude, initialLongitude: longitude),

        // Volver
        Positioned(
          top: 40,
          left: 20,
          child: IconButton.filledTonal(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back),
          ),
        ),

        // Ir a la posición del usuario
        Positioned(
          bottom: 40,
          left: 20,
          child: IconButton.filledTonal(
            onPressed:
                () => ref.read(mapControllerProvider.notifier).findUser(),
            icon: const Icon(Icons.location_searching),
          ),
        ),

        // Seguir usuario
        Positioned(
          bottom: 90,
          left: 20,
          child: IconButton.filledTonal(
            onPressed:
                () =>
                    ref.read(mapControllerProvider.notifier).toggleFollowUser(),
            icon: Icon(
              mapController.followUser
                  ? Icons.directions_run
                  : Icons.accessibility_new_outlined,
            ),
          ),
        ),

        // Crear Marcador
        Positioned(
          bottom: 140,
          left: 20,
          child: IconButton.filledTonal(
            onPressed:
                () => ref
                    .read(mapControllerProvider.notifier)
                    .addMarkerCurrentPosition(
                      'Punto de Control ${mapController.markers.length + 1}',
                    ),
            icon: Icon(Icons.pin_drop),
          ),
        ),
      ],
    );
  }
}

class _MapView extends ConsumerStatefulWidget {
  final double initialLatitude;
  final double initialLongitude;
  const _MapView({
    required this.initialLatitude,
    required this.initialLongitude,
  });

  @override
  ConsumerState<_MapView> createState() => __MapViewState();
}

class __MapViewState extends ConsumerState<_MapView> {
  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(mapControllerProvider);

    return GoogleMap(
      markers: controller.markersSet,
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: LatLng(widget.initialLatitude, widget.initialLongitude),
        zoom: 12,
      ),
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      onMapCreated: (GoogleMapController controller) {
        ref.read(mapControllerProvider.notifier).setMapController(controller);
      },
      onLongPress:
          (latLng) => ref
              .read(mapControllerProvider.notifier)
              .addMarker(latLng.latitude, latLng.longitude, 'Custom marker'),
    );
  }
}

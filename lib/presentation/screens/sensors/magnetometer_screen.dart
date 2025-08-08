import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class MagnetometerScreen extends ConsumerWidget {
  const MagnetometerScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    // final accelerometerGravity = ref.watch(accelerometerGravityProvider);
    final magnetometer = ref.watch(magnetometerProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Magnetómetro')),
      body: Center(
        child: magnetometer.when(
          data: (data) => Text(data.toString(), style: TextStyle(fontSize: 20)),
          error: (error, stackTrace) => const Text('Error'),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}

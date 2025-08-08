import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class AccelerometerScreen extends ConsumerWidget {
  const AccelerometerScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    // final accelerometerGravity = ref.watch(accelerometerGravityProvider);
    final accelerometerUser = ref.watch(accelerometerUserProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Acelerómetro')),
      body: Center(
        child: accelerometerUser.when(
          data: (data) => Text(data.toString(), style: TextStyle(fontSize: 20)),
          error: (error, stackTrace) => const Text('Error'),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}

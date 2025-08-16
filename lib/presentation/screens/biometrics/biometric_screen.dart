import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class BiometricScreen extends ConsumerWidget {
  const BiometricScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final canCheckBiometrics = ref.watch(canCheckBiometricsProvider);
    final localAuthState = ref.watch(localAuthProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Biométricos')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.tonal(
              onPressed:
                  () => ref.read(localAuthProvider.notifier).authenticateUser(),
              // .authenticateUser(biometricOnly: true),
              child: Text('Verificar identidad'),
            ),

            canCheckBiometrics.when(
              data: (canCheck) => Text('Biométricos disponibles: $canCheck'),
              error: (error, _) => Text('Error: $error'),
              loading: () => CircularProgressIndicator(),
            ),

            const SizedBox(height: 40),

            Text(localAuthState.toString(), style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}

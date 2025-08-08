import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';
import 'package:miscelaneos/presentation/screens/screens.dart';

class CompassScreen extends ConsumerWidget {
  const CompassScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final locationGranted = ref.watch(permissionsProvider).locationGranted;

    if (!locationGranted) {
      return const AskLocationScreen();
    }
    final compass$ = ref.watch(compassProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Brújula'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: compass$.when(
          data: (data) => Compass(heading: data ?? 0),
          error: (error, stackTrace) => Text('$error'),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class Compass extends StatefulWidget {
  final double heading;
  const Compass({required this.heading, super.key});

  @override
  State<Compass> createState() => _CompassState();
}

class _CompassState extends State<Compass> {
  double prevValue = 0.0;
  double turns = 0;

  double getTurns() {
    double? direction = widget.heading;
    direction = (direction < 0) ? (360 + direction) : direction;

    double diff = direction - prevValue;
    if (diff.abs() > 180) {
      if (prevValue > direction) {
        diff = 360 - (direction - prevValue).abs();
      } else {
        diff = 360 - (prevValue - direction).abs();
        diff = diff * -1;
      }
    }

    turns += (diff / 360);
    prevValue = direction;

    return turns * -1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Posición: ${widget.heading.ceil()}',
          style: GoogleFonts.montserratAlternates().copyWith(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        const SizedBox(height: 20),
        Stack(
          alignment: Alignment.center,
          children: [
            AnimatedRotation(
              curve: Curves.easeOut,
              turns: getTurns(),
              duration: const Duration(seconds: 1),
              child: Image.asset(
                'assets/images/compass/quadrant-3.png',
                scale: 1.2,
              ),
            ),
            Image.asset('assets/images/compass/needle-6.png', scale: 1.2),
          ],
        ),
      ],
    );
  }
}

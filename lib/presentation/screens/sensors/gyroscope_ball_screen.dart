import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class GyroscopeBallScreen extends ConsumerWidget {
  const GyroscopeBallScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final gyroscope = ref.watch(gyroscopeProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Giroscopio Ball')),
      body: SizedBox.expand(
        child: gyroscope.when(
          data: (data) => MovingBall(x: data.x, y: data.y),
          error: (error, stackTrace) => Text('Error: $error'),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

class MovingBall extends StatelessWidget {
  final double x;
  final double y;

  const MovingBall({super.key, required this.x, required this.y});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double screenWidth = size.width;
    double screenHeight = size.height;

    double currentYPos = (y * 100);
    double currentXPos = (x * 100);

    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedPositioned(
          left: (currentYPos - 25) + (screenWidth / 2),
          top: (currentXPos - 25) + (screenHeight / 2),
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 1000),
          child: Ball(),
        ),
        Text('''
            X:$x
            Y:$y
            ''', style: const TextStyle(fontSize: 30)),
      ],
    );
  }
}

class Ball extends StatelessWidget {
  const Ball({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}

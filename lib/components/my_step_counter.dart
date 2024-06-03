import 'package:flutter/material.dart';

class MyStepCounter extends StatelessWidget {
  final int steps;
  final double distance;
  final Duration walkingTime;

  const MyStepCounter(
      {super.key,
      required this.steps,
      required this.distance,
      required this.walkingTime});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Шаги: $steps',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(
          'Расстояние: ${distance.toStringAsFixed(2)} км',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          'Время ходьбы: ${walkingTime.inMinutes} минут',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }
}

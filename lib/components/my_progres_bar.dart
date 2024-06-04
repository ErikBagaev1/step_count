import 'package:flutter/material.dart';

class MyProgresBar extends StatelessWidget {
  final double progress;
  final int steps;
  final int goal;

  const MyProgresBar({
    super.key,
    required this.progress,
    required this.steps,
    required this.goal,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          LinearProgressIndicator(
            borderRadius: BorderRadius.circular(10),
            minHeight: 20,
            value: progress,
          ),
          const SizedBox(
              height:
                  8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Пройдено шагов: $steps',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                'Цель: $goal',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

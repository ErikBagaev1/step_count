import 'package:flutter/material.dart';

class MyProgresBar extends StatelessWidget {
  final double progress;

  const MyProgresBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LinearProgressIndicator(
        borderRadius: BorderRadius.circular(10),
        minHeight: 20,
        value: progress,
      ),
    );
  }
}

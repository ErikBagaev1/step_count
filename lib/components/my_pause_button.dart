import 'package:flutter/material.dart';

class MyPauseButton extends StatelessWidget {
  final bool isPaused;
  final VoidCallback onPressed;

  const MyPauseButton(
      {super.key, required this.isPaused, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
            WidgetStateProperty.all<Color>(Colors.blue), // Цвет фона кнопки
        foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
      ),
      onPressed: onPressed,
      child: Text(
        isPaused ? 'Продолжить' : 'Пауза',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}

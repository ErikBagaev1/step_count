import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/step_model.dart';

class StepProvider with ChangeNotifier {
  final StepModel _stepModel = StepModel();
  // late Pedometer _pedometer;
  late StreamSubscription<StepCount> _subscription;
  final Stopwatch _stopwatch = Stopwatch();

  StepProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    _loadGoal();
    // _pedometer = Pedometer();
    _subscription = Pedometer.stepCountStream.listen((StepCount event) {
      if (!_stepModel.isPaused) {
        _stepModel.steps += event.steps;
        _stepModel.distance += event.steps * 0.0008;
        _stepModel.walkingTime = _stopwatch.elapsed;
        notifyListeners();
      }
    });
  }

  StepModel get stepModel => _stepModel;

  void _loadGoal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _stepModel.goal = prefs.getInt('goal') ?? 10000;
    notifyListeners();
  }

  void setGoal(int goal) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('goal', goal);
    _stepModel.goal = goal;
    notifyListeners();
  }

  void togglePause() {
    _stepModel.isPaused = !_stepModel.isPaused;
    if (_stepModel.isPaused) {
      _stopwatch.stop();
    } else {
      _stopwatch.start();
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription.cancel();
    _stopwatch.stop();
    super.dispose();
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/step_model.dart';

class StepProvider with ChangeNotifier {
  final StepModel _stepModel = StepModel();
  late StreamSubscription<StepCount> _stepCountSubscription;

  StepProvider() {
    _requestPermission();
  }

  StepModel get stepModel => _stepModel;

  Future<void> _requestPermission() async {
    var status = await Permission.activityRecognition.status;
    if (status.isDenied || status.isPermanentlyDenied) {
    } else if (status.isGranted) {
      _initializeStepCounter();
    }
  }

  Future<void> _initializeStepCounter() async {
    _stepCountSubscription =
        Pedometer.stepCountStream.listen((StepCount event) {
      if (!_stepModel.isPaused) {
        _stepModel.steps = event.steps;
        notifyListeners();
      }
    });
    notifyListeners();
  }

  void setGoal(int goal) {
    _stepModel.goal = goal;
    notifyListeners();
  }

  void togglePause() {
    _stepModel.isPaused = !_stepModel.isPaused;
    notifyListeners();
  }

  @override
  void dispose() {
    _stepCountSubscription.cancel();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/my_pause_button.dart';
import '../components/my_progres_bar.dart';
import '../components/my_step_counter.dart';
import '../providers/step_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Шагомер'),
      ),
      body: Consumer<StepProvider>(
        builder: (context, stepProvider, child) {
          final stepModel = stepProvider.stepModel;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MyStepCounter(
                  steps: stepModel.steps,
                  distance: stepModel.distance,
                  walkingTime: stepModel.walkingTime,
                ),
                const SizedBox(
                  height: 20,
                ),
                MyProgresBar(
                  progress: stepModel.steps / stepModel.goal,
                ),
                const SizedBox(
                  height: 20,
                ),
                MyPauseButton(
                  isPaused: stepModel.isPaused,
                  onPressed: stepProvider.togglePause,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

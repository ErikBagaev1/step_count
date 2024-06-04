import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../components/my_pause_button.dart';
import '../components/my_progres_bar.dart';
import '../components/my_step_counter.dart';
import '../providers/step_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  Future<void> _requestPermission() async {
    var status = await Permission.activityRecognition.status;
    if (status.isDenied || status.isPermanentlyDenied) {
      _showPermissionDialog();
    } else if (status.isGranted) {}
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Разрешение необходимо'),
          content: const Text(
              'Приложению необходимо разрешение на использование шагомера.'),
          actions: [
            TextButton(
              child: const Text('Отмена'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Подтвердить'),
              onPressed: () async {
                Navigator.of(context).pop();
                if (await Permission.activityRecognition.request().isGranted) {
                  setState(() {

                    
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Шагомер'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () =>
                _showGoalDialog(context, context.read<StepProvider>()),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Consumer<StepProvider>(
        builder: (context, stepProvider, child) {
          final stepData = stepProvider.stepModel;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MyStepCounter(
                  steps: stepData.steps,
                  distance: stepData.distance,
                  walkingTime: stepData.walkingTime,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyProgresBar(
                    progress: stepData.steps / stepData.goal,
                    steps: stepData.steps,
                    goal: stepData.goal,
                  ),
                ),
                if (stepData.goal > 0)
                  MyPauseButton(
                    isPaused: stepData.isPaused,
                    onPressed: stepProvider.togglePause,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showGoalDialog(BuildContext context, StepProvider stepProvider) {
    final TextEditingController goalController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Установить цель шагов'),
          content: TextField(
            controller: goalController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Цель'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                final int? goal = int.tryParse(goalController.text);
                if (goal != null && goal > 0) {
                  stepProvider.setGoal(goal);
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content:
                        Text('Пожалуйста, введите корректное значение цели.'),
                  ));
                }
              },
              child: const Text('Подтвердить'),
            ),
          ],
        );
      },
    );
  }
}

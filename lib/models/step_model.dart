class StepModel {
  int steps;
  int goal;
  bool isPaused;
  double distance;
  Duration walkingTime;

  StepModel({
    this.steps = 0,
    this.goal = 10000,
    this.isPaused = false,
    this.distance = 0.0,
    this.walkingTime = const Duration(),
  });
}

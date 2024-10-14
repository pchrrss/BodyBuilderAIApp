import 'package:flutter/material.dart';
import 'package:bodybuilderaiapp/model/workout_day.dart';

class WorkoutDayProgress extends StatelessWidget {
  final WorkoutDay workoutDay;

  const WorkoutDayProgress({
    super.key,
    required this.workoutDay,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            workoutDay.focusArea,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(workoutDay.totalExercises, (index) {
              return Padding(
                padding: const EdgeInsetsDirectional.only(end: 4.0),
                child: Container(
                  width: 50,
                  height: 8,
                  decoration: BoxDecoration(
                    color: index < workoutDay.completedExercises ? Colors.green : Colors.grey[600],
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 10),
          Text(
            'Workouts completed: ${workoutDay.completedExercises} of ${workoutDay.totalExercises}',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:bodybuilderaiapp/model/workout_day.dart'; // Assuming you have the model defined here

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
          // Title Text
          Text(
            workoutDay.day,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16), // Spacing between title and progress
          
          // Progress Bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(workoutDay.totalExercises, (index) {
              return Container(
                width: 40,
                height: 8,
                decoration: BoxDecoration(
                  color: index < workoutDay.completedExercises ? Colors.green : Colors.grey[600],
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
          
          const SizedBox(height: 10), // Spacing between progress and status

          // Status Text
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

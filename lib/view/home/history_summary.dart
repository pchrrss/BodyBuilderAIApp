import 'package:flutter/material.dart';

class HistorySummary extends StatelessWidget {
  const HistorySummary({
    super.key,
    required this.completedPlans,
    required this.totalCompletedWorkoutDays,
    required this.totalCompletedExercises,
  });

  final int completedPlans;
  final int totalCompletedWorkoutDays;
  final int totalCompletedExercises;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          '$completedPlans',
          style: const TextStyle(fontSize: 80, fontFamily: "NotoSans", fontWeight: FontWeight.bold, height: 1),
        ),

        const Text(
          'Plans Completed',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  '$totalCompletedWorkoutDays',
                  style: const TextStyle(fontSize: 50, fontFamily: "NotoSans", fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Workout Days Completed',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  '$totalCompletedExercises',
                  style: const TextStyle(fontSize: 50, fontFamily: "NotoSans", fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Exercises Completed',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

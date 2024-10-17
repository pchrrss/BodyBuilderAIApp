import 'package:bodybuilderaiapp/model/exercise.dart';
import 'package:bodybuilderaiapp/view/home/history_summary.dart';
import 'package:flutter/material.dart';
import 'package:bodybuilderaiapp/model/fitness_plan_result.dart';
import 'package:intl/intl.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class HistoryScreen extends StatefulWidget {
  final List<FitnessPlanResult> fitnessPlans;

  const HistoryScreen({super.key, required this.fitnessPlans});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late int completedPlans;
  late int totalCompletedWorkoutDays;
  late int totalCompletedExercises;
  Map<String, List<Exercise>> completedExercisesByMonth = {};

  @override
  void initState() {
    super.initState();
    _calculateCompletedStats();
    _groupExercisesByMonth();
  }

  void _calculateCompletedStats() {
    completedPlans = widget.fitnessPlans.where((plan) => plan.isCompleted()).length;

    totalCompletedWorkoutDays = widget.fitnessPlans.fold(0, (sum, plan) {
      return sum + plan.completedWorkoutDays();
    });

    totalCompletedExercises = widget.fitnessPlans.fold(0, (sum, plan) {
      return sum + plan.completedExercises();
    });
  }

  void _groupExercisesByMonth() {
    completedExercisesByMonth = widget.fitnessPlans
        .where((plan) => plan.isCompleted())
        .expand((plan) => plan.workoutDays)
        .expand((day) => day.exercises)
        .fold<Map<String, List<Exercise>>>({}, (acc, exercise) {
      String monthYear = DateFormat('MMMM yyyy').format(exercise.completedAt!);
      acc.update(
        monthYear,
        (exercises) => [...exercises, exercise]..sort((a, b) => b.completedAt!.compareTo(a.completedAt!)),
        ifAbsent: () => [exercise],
      );
      return acc;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            HistorySummary(
                completedPlans: completedPlans,
                totalCompletedWorkoutDays: totalCompletedWorkoutDays,
                totalCompletedExercises: totalCompletedExercises),
            const Divider(height: 40),
            _buildExerciseHistory(),
          ],
        ),
      ),
    );
  }

Widget _buildExerciseHistory() {
  return Expanded(
    child: ListView.builder(
      itemCount: completedExercisesByMonth.length,
      itemBuilder: (context, index) {
        String monthYear = completedExercisesByMonth.keys.elementAt(index);
        List<Exercise> exercises = completedExercisesByMonth[monthYear]!;

        return StickyHeader(
          header: Container(
            color: Colors.white,
            child: Row(
              children: [
                Text(
                  monthYear,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          content: Column(
            children: [
              ...exercises.map((exercise) => _buildExerciseListItem(exercise)),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    ),
  );
}

  Widget _buildExerciseListItem(Exercise exercise) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          exercise.getExerciseImageAsset(false),
          height: 50,
          width: 50,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 50,
              width: 50,
              color: Colors.grey[300],
              child: const Icon(Icons.image_not_supported),
            );
          },
        ),
      ),
      title: Text(exercise.name),
      subtitle: Text(
        DateFormat('E, dd MMM  H:mm').format(exercise.completedAt ?? DateTime.now()),
        style: const TextStyle(color: Colors.grey),
      ),
    );
  }
}

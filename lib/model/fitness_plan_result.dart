import 'package:bodybuilderaiapp/model/workout_day.dart';

class FitnessPlanResult {
  final String id;
  final String? ageRange;
  final String? bodyType;
  final String? goal;
  final String? bodyFatRange;
  final int? fitnessLevel;
  final String? equipment;
  final int? workoutFrequencyPerWeek;
  final DateTime? createdAt;
  final List<WorkoutDay> workoutDays;

  FitnessPlanResult({
    required this.id,
    required this.ageRange,
    required this.bodyType,
    required this.goal,
    required this.bodyFatRange,
    required this.fitnessLevel,
    required this.equipment,
    required this.workoutFrequencyPerWeek,
    required this.createdAt,
    required this.workoutDays,
  });

  factory FitnessPlanResult.from(String id, Map<String, dynamic> data, List<WorkoutDay> workoutDays) {
    return FitnessPlanResult(
      id: id,
      ageRange: data['ageRange'],
      bodyType: data['bodyType'],
      goal: data['goal'],
      bodyFatRange: data['bodyFatRange'],
      fitnessLevel: data['fitnessLevel'],
      equipment: data['equipment'],
      workoutFrequencyPerWeek: data['workoutFrequencyPerWeek'],
      createdAt: data['createdAt'].toDate(),
      workoutDays: workoutDays,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'age_range': ageRange,
      'body_type': bodyType,
      'goal': goal,
      'body_fat_range': bodyFatRange,
      'fitness_level': fitnessLevel,
      'equipment': {equipment},
      'workout_frequency_per_week': workoutFrequencyPerWeek,
      'createdAt': createdAt,
      'workout_plan': workoutDays.map((day) => day.toJson()).toList(),
    };
  }
}

class FitnessPlanResult {
  final String ageRange;
  final String bodyType;
  final String goal;
  final String bodyFatRange;
  final int fitnessLevel;
  final String equipment;
  final int workoutFrequencyPerWeek;
  final List<WorkoutDay> workoutPlan;

  FitnessPlanResult({
    required this.ageRange,
    required this.bodyType,
    required this.goal,
    required this.bodyFatRange,
    required this.fitnessLevel,
    required this.equipment,
    required this.workoutFrequencyPerWeek,
    required this.workoutPlan,
  });

  factory FitnessPlanResult.fromJson(Map<String, dynamic> json) {
    return FitnessPlanResult(
      ageRange: json['age_range'],
      bodyType: json['body_type'],
      goal: json['goal'],
      bodyFatRange: json['body_fat_range'],
      fitnessLevel: json['fitness_level'],
      equipment: json['equipment']['Note'],
      workoutFrequencyPerWeek: json['workout_frequency_per_week'],
      workoutPlan: (json['workout_plan'] as List<dynamic>)
          .map((day) => WorkoutDay.fromJson(day))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'age_range': ageRange,
      'body_type': bodyType,
      'goal': goal,
      'body_fat_range': bodyFatRange,
      'fitness_level': fitnessLevel,
      'equipment': {'Note': equipment},
      'workout_frequency_per_week': workoutFrequencyPerWeek,
      'workout_plan': workoutPlan.map((day) => day.toJson()).toList(),
    };
  }
}

class WorkoutDay {
  final String day;
  final String focusArea;
  final List<Exercise> exercises;

  WorkoutDay({
    required this.day,
    required this.focusArea,
    required this.exercises,
  });

  factory WorkoutDay.fromJson(Map<String, dynamic> json) {
    return WorkoutDay(
      day: json['day'],
      focusArea: json['focus_area'],
      exercises: (json['exercises'] as List<dynamic>)
          .map((exercise) => Exercise.fromJson(exercise))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'focus_area': focusArea,
      'exercises': exercises.map((exercise) => exercise.toJson()).toList(),
    };
  }
}

class Exercise {
  final String name;
  final int sets;
  final String reps;

  Exercise({
    required this.name,
    required this.sets,
    required this.reps,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json['name'],
      sets: json['sets'],
      reps: json['reps'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'sets': sets,
      'reps': reps,
    };
  }
}

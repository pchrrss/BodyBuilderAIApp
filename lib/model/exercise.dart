import 'package:bodybuilderaiapp/model/base_exercise.dart';

class Exercise extends BaseExercise{
  int sets;
  String reps;
  bool completed;
  DateTime? completedAt;
  Set<String> alreadySuggestedExercises;

  Exercise({
    required super.id,
    required super.name,
    required this.sets,
    required this.reps,
    this.completed = false,
    super.instruction,
    this.completedAt,
    this.alreadySuggestedExercises = const <String>{},
  });

  factory Exercise.from(String id, Map<String, dynamic> data) {
    return Exercise(
      id: id,
      name: data['name'],
      sets: data['sets'],
      reps: data['reps'].toString(),
      completed: data['completed'] ?? false,
      instruction: data['instruction'],
      completedAt: data['completedAt']?.toDate(),
      alreadySuggestedExercises: (data['alreadySuggestedExercises'] as List<dynamic>?)?.map((e) => e.toString()).toSet() ?? <String>{},
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'sets': sets,
      'reps': reps,
      'completed': completed,
      'instruction': instruction,
      'completedAt': completedAt,
      'alreadySuggestedExercises': alreadySuggestedExercises,
    };
  }

  Exercise copyWith({
    String? id,
    String? name,
    int? sets,
    String? reps,
    bool? completed,
    String? instruction,
  }) {
    return Exercise(
      id: id ?? this.id,
      name: name ?? this.name,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      completed: completed ?? this.completed,
      instruction: instruction ?? this.instruction,
    );
  }
}

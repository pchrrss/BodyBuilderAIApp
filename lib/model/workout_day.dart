import 'package:bodybuilderaiapp/model/exercise.dart';

class WorkoutDay {
  final String id;
  final String day;
  final String focusArea;
  final List<Exercise> exercises;

  WorkoutDay({
    required this.id,
    required this.day,
    required this.focusArea,
    required this.exercises,
  });

  factory WorkoutDay.from(String id, Map<String, dynamic> data, List<Exercise> exercises) {
    return WorkoutDay(
      id: id,
      day: data['day'],
      focusArea: data['focusArea'],
      exercises: exercises,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'focusArea': focusArea,
      'exercises': exercises.map((exercise) => exercise.toJson()).toList(),
    };
  }

  WorkoutDay copyWith({
    String? id,
    String? day,
    String? focusArea,
    List<Exercise>? exercises,
  }) {
    return WorkoutDay(
      id: id ?? this.id,
      day: day ?? this.day,
      focusArea: focusArea ?? this.focusArea,
      exercises: exercises ?? this.exercises,
    );
  }
}

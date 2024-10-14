import 'package:bodybuilderaiapp/model/base_exercise.dart';

class FavoriteExercise extends BaseExercise {
  FavoriteExercise({
    required super.id,
    required super.name,
    super.instruction,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'instruction': instruction,
    };
  }

  factory FavoriteExercise.from(String id, Map<String, dynamic> data) {
    return FavoriteExercise(
      id: id,
      name: data['name'],
      instruction: data['instruction'],
    );
  }
}

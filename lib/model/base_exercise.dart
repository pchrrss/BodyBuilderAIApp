abstract class BaseExercise {
  String id;
  String name;
  String? instruction;

  BaseExercise({
    required this.id,
    required this.name,
    this.instruction,
  });

  String getExerciseImageAsset(bool isImageToggled) {
    String fileName = name.replaceAll(' ', '_');
    return 'assets/img/exercises/${fileName}_${isImageToggled ? '0' : '1'}.jpg';
  }

  Map<String, dynamic> toJson();
}

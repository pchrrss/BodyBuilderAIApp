class UserInputModel {
  String? ageRange;
  String? bodyType;
  String? fitnessGoal;
  String? bodyFatRange;
  Set<String>? focusAreas;
  int? fitnessLevel;
  String? equipment;
  int? workoutDays;

  UserInputModel({
    this.ageRange,
    this.bodyType,
    this.fitnessGoal,
    this.bodyFatRange,
    this.focusAreas,
    this.fitnessLevel,
    this.equipment,
    this.workoutDays,
  });

  @override
  String toString() {
    return '''
    UserInputModel {
      ageRange: $ageRange,
      bodyType: $bodyType,
      fitnessGoal: $fitnessGoal,
      bodyFatRange: $bodyFatRange,
      focusArea: $focusAreas,
      fitnessLevel: $fitnessLevel,
      equipment: $equipment,
      workoutDays: $workoutDays
    }
    ''';
  }
}

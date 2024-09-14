class UserInputModel {
  String? fitnessGoal;
  String? bodyType;
  Set<String>? focusAreas;
  String? equipment;
  String? ageRange;
  String? bodyFatRange;
  int? fitnessLevel;
  int? workoutDays;

  UserInputModel({
    this.fitnessGoal,
    this.bodyType,
    this.focusAreas,
    this.equipment,
    this.ageRange,
    this.bodyFatRange,
    this.fitnessLevel,
    this.workoutDays,
  });

  @override
  String toString() {
    return '''
    UserInputModel {
      fitnessGoal: $fitnessGoal,
      bodyType: $bodyType,
      focusArea: $focusAreas,
      equipment: $equipment,
      ageRange: $ageRange,
      bodyFatRange: $bodyFatRange,
      fitnessLevel: $fitnessLevel,
      workoutDays: $workoutDays
    }
    ''';
  }
}

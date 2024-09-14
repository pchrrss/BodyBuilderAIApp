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

  static const List fitnessGoalOptions = [
    {
      "image": "assets/img/goals/gain_muscle.png",
      "title": "Gain Muscle",
      "subTitle": "Strengthen and grow your muscles with focused training."
    },
    {
      "image": "assets/img/goals/lose_weight.png",
      "title": "Lose Weight",
      "subTitle": "Achieve a leaner physique with a targeted approach."
    },
    {
      "image": "assets/img/goals/get_shredded.png",
      "title": "Get Shredded",
      "subTitle": "Carve out defined muscles with precision workouts."
    },
    {
      "image": "assets/img/goals/maintain_fitness.png",
      "title": "Maintain Fitness",
      "subTitle": "Stay in peak condition with balanced routines."
    },
  ];

  static const List bodyTypeOptions = [
    {
      "image": "assets/img/bodytypes/slim.png",
      "title": "Slim",
      "subTitle": "A lean and toned figure with a slender build."
    },
    {
      "image": "assets/img/bodytypes/average.png",
      "title": "Average",
      "subTitle": "A balanced figure with moderate muscle and body fat."
    },
    {
      "image": "assets/img/bodytypes/heavy.png",
      "title": "Heavy",
      "subTitle": "A stockier, broader figure with higher body mass and fat."
    },
  ];

  static const List focusAreaOptions = [
    {"image": "assets/img/focusareas/legs.png", "title": "Legs"},
    {"image": "assets/img/focusareas/abdomen.png", "title": "Abdomen"},
    {"image": "assets/img/focusareas/arms.png", "title": "Arms"},
    {"image": "assets/img/focusareas/chest.png", "title": "Chest"},
    {"image": "assets/img/focusareas/back.png", "title": "Back"},
    {"image": "assets/img/focusareas/fullbody.png", "title": "Full Body"},
  ];

  static const List<String> ageRangeOptions = [
    '18-29',
    '30-39',
    '40-49',
    '50-59',
    '60+'
  ];

  static const List<String> bodyFatRangeOptions = [
    '5-9%',
    '10-14%',
    '15-19%',
    '20-24%',
    '25-29%',
    '30-34%',
    '35-39%',
    '40+%'
  ];

  static const List<String> equipmentOptions = [
    'No equipment',
    'Basic equipment',
    'Full equipment'
  ];
  
  String generateFitnessPlanRequest() {
    String focusAreaSentence = getFocusAreaSentence();

    return '''
      I am a ${ageRange ?? 'unspecified'} years old person with a ${bodyType ?? 'unspecified'} body type.
      My goal is to ${fitnessGoal ?? 'improve my overall fitness'}, and I want to focus on my $focusAreaSentence.
      Currently, my body fat percentage is around ${bodyFatRange ?? 'unspecified'}, and my fitness level is ${fitnessLevel ?? 'average'}/10.
      I have access to ${equipment ?? 'no equipment'}, and I plan to work out ${workoutDays ?? '3'} days a week.
      Can you generate a fitness plan for me based on these details?
    ''';
  }

  String getFocusAreaSentence() {
    if (focusAreas != null && focusAreas!.isNotEmpty) {
      final focusAreaList = focusAreas!.toList();
      if (focusAreaList.length == 1) {
        return focusAreaList[0];
      } else {
        return '${focusAreaList.sublist(0, focusAreaList.length - 1).join(', ')} and ${focusAreaList.last}';
      }
    }
    return 'entire body';
  }

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

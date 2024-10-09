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
    {"image": "assets/img/goals/gain_muscle.png", "title": "Gain Muscle", "subTitle": "Strengthen and grow your muscles with focused training."},
    {"image": "assets/img/goals/lose_weight.png", "title": "Lose Weight", "subTitle": "Achieve a leaner physique with a targeted approach."},
    {"image": "assets/img/goals/get_shredded.png", "title": "Get Shredded", "subTitle": "Carve out defined muscles with precision workouts."},
    {"image": "assets/img/goals/maintain_fitness.png", "title": "Maintain Fitness", "subTitle": "Stay in peak condition with balanced routines."},
  ];

  static const List bodyTypeOptions = [
    {"image": "assets/img/bodytypes/slim.png", "title": "Slim", "subTitle": "A lean and toned figure with a slender build."},
    {"image": "assets/img/bodytypes/average.png", "title": "Average", "subTitle": "A balanced figure with moderate muscle and body fat."},
    {"image": "assets/img/bodytypes/heavy.png", "title": "Heavy", "subTitle": "A stockier, broader figure with higher body mass and fat."},
  ];

  static const List focusAreaOptions = [
    {"image": "assets/img/focusareas/legs.png", "title": "Legs"},
    {"image": "assets/img/focusareas/abdomen.png", "title": "Abdomen"},
    {"image": "assets/img/focusareas/arms.png", "title": "Arms"},
    {"image": "assets/img/focusareas/chest.png", "title": "Chest"},
    {"image": "assets/img/focusareas/back.png", "title": "Back"},
    {"image": "assets/img/focusareas/fullbody.png", "title": "Full Body"},
  ];

  static const List<String> ageRangeOptions = ['18-29', '30-39', '40-49', '50-59', '60+'];

  static const List<String> bodyFatRangeOptions = ['5-9%', '10-14%', '15-19%', '20-24%', '25-29%', '30-34%', '35-39%', '40+%'];

  static const List<String> equipmentOptions = ['No equipment', 'Basic equipment', 'Full equipment'];

 String generateFitnessPlanRequest() {
  String focusAreaSentence = getFocusAreaSentence();

  return '''
I am a ${ageRange ?? 'unspecified'} years old person with a ${bodyType ?? 'unspecified'} body type. My goal is to ${fitnessGoal ?? 'improve my overall fitness'}, and I want to focus on ${focusAreaSentence}. Currently, my body fat percentage is around ${bodyFatRange ?? 'unspecified'}, and my fitness level is ${fitnessLevel ?? 'average'}/10. I have access to ${equipment ?? 'no equipment'}, and I plan to work out ${workoutDays ?? '3'} days a week.

Based on this information, generate a fitness plan for me in JSON format using the following structure:

{
  "workout_days": [
    {
      "day": "1",
      "focus_area": "A specific focus area",
      "exercises": [
        {
          "name": "Exercise 1",
          "instruction": "Instruction for proper execution",
          "sets": 3,
          "reps": "12 reps or a time duration"
        }
      ]
    },
    {
      "day": "2",
      "focus_area": "A specific focus area",
      "exercises": [
        {
          "name": "Exercise 2",
          "instruction": "Instruction for proper execution",
          "sets": 4,
          "reps": "10 reps or a time duration"
        }
      ]
    }
    // Add more days as needed
  ]
}

Make sure:
- The number of workout days is exactly ${workoutDays ?? '3'}.
- The 'day' field is a string starting from "1" to the number of workout days.
- Each day has a specific focus area; there should be no rest days.
- Avoid any mention of nutrition.
- Respond only in valid JSON format without any additional characters, explanations, or comments.
  ''';


    // return '''
    //   I am a ${ageRange ?? 'unspecified'} years old person with a ${bodyType ?? 'unspecified'} body type. My goal is to ${fitnessGoal ?? 'improve my overall fitness'}, and I want to focus on my $focusAreaSentence. Currently, my body fat percentage is around ${bodyFatRange ?? 'unspecified'}, and my fitness level is ${fitnessLevel ?? 'average'}/10. I have access to ${equipment ?? 'no equipment'}, and I plan to work out ${workoutDays ?? '3'} days a week.
    //   Can you generate a fitness plan for me in JSON format based on these details, including the following structure:
    //     * workout_days: an array of ${workoutDays ?? '3'} elements, in any case you should have an number of element different of ${workoutDays ?? '3'}, with:
    //         * day: a string representing week's day this week's day should be a number represented in string between 1 and ${workoutDays ?? '3'} of the training.
    //         * focus_area: the main focus area for the training, if it's a rest day, the focus area will 'Rest day'.
    //         * exercises: an array of exercises for the day, With:
    //             * name: the name of the exercise.
    //             * instruction: give some instructions to how apply correctly the exercise.
    //             * sets: the number of sets for the exercise.
    //             * reps: a string representation of repetitions per set or times of execution.
      
    //   Avoid any mention of nutrition.
    //   Please respond only in valid JSON format, without any additional characters or text. Do not include explanations, comments, or extra characters.
    //   ''';
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

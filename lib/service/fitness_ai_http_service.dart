import 'package:bodybuilderaiapp/model/exercise.dart';
import 'package:bodybuilderaiapp/model/fitness_plan_result.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FitnessAiHttpService {
  final String apiUrl = 'http://localhost:11434/api/generate';

  Future<Map<String, dynamic>> generateFitnessPlan(String fitnessPlanRequest) async {
    print(fitnessPlanRequest);
    var url = Uri.parse(apiUrl);

    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "model": "body-builder-model",
        "prompt": fitnessPlanRequest,
        //fixme ?
        "stream": false,
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(jsonDecode(data['response']));
      return jsonDecode(data['response']);
    } else {
      throw Exception('Failed to generate fitness plan');
    }
  }

  Future<Map<String, dynamic>> _mockFitnessPlan() async {
    await Future.delayed(Duration(seconds: 3));
    return {
      "age_range": "40-49",
      "body_type": "Heavy",
      "goal": "Gain Muscle Mass & Lose Weight",
      "focus_areas": ["Building Strength"],
      "body_fat_range": "10-14",
      "fitness_level": 2,
      "equipment": {"Note": "None"},
      "workout_frequency_per_week": 5,
      "workout_days": [
        {
          "day": "day 1",
          "focus_area": "Building Lower Body Strength",
          "exercises": [
            {"name": "Burpees (Bodyweight)", "sets": 3, "reps": 12},
            {"name": "Squats (Bodyweight)", "sets": 4, "reps": 15}
          ]
        },
        {
          "day": "day 2",
          "focus_area": "Building Upper Body Strength",
          "exercises": [
            {"name": "Pushups (Bodyweight)", "sets": 3, "reps": 12},
            {"name": "Arm Raises (Bodyweight)", "sets": 3, "reps": 12}
          ]
        },
        {
          "day": "day 3",
          "focus_area": "Functional Movement Training",
          "exercises": [
            {"name": "Plank Sit-Ups (Bodyweight)", "sets": 2, "reps": 12},
            {"name": "Side Planks (Bodyweight, each side separately)", "sets": 3, "reps": "Hold for as long as possible (~30 seconds each)"}
          ]
        },
        {
          "day": "day 4",
          "focus_area": "Lower Body Strength",
          "exercises": [
            {"name": "Calisthenic Lunges (Bodyweight, leg lead change with each rep)", "sets": 4, "reps": 15}
          ]
        },
        {
          "day": "day 5",
          "focus_area": "Cardiovascular Interval Training & Abs Strength",
          "exercises": [
            {"name": "Plank Marches (Bodyweight), Alternate Left, Then Right", "sets": 2, "reps": 20}
          ]
        }
      ]
    };
  }

  Future<Map<String, dynamic>> suggestReplacementExercise(String focusArea, Exercise exercise) async {
    var url = Uri.parse(apiUrl);
    return await _mockExercise();
    // var response = await http.post(
    //   url,
    //   headers: {
    //     'Content-Type': 'application/json',
    //   },
    //   body: jsonEncode({
    //     "model": "llama3",
    //     "prompt": "replace exercise $exercise.name for $focusArea",
    //     //fixme ?
    //     "stream": false,
    //   }),
    // );

    // if (response.statusCode == 200) {
    //   var data = jsonDecode(response.body);
    //   return data['response'];
    // } else {
    //   throw Exception('Failed to fetch replacement exercise');
    // }
  }

  Future<Map<String, dynamic>> _mockExercise() async {
    await Future.delayed(Duration(seconds: 3));
    return {"name": "Burpees (Bodyweight)", "sets": 3, "reps": 12};
  }
}

import 'package:bodybuilderaiapp/model/exercise.dart';
import 'package:bodybuilderaiapp/model/workout_day.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:logger/web.dart';

class FitnessAiHttpService {
  var logger = Logger();
  final String apiUrl = dotenv.env['AI_API_URL']!;
  final String model = dotenv.env['MODEL_NAME']!;

  Future<Map<String, dynamic>> generateFitnessPlan(String fitnessPlanRequest) async {
    logger.i(fitnessPlanRequest);
    var url = Uri.parse(apiUrl);

    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "model": model,
        "prompt": fitnessPlanRequest,
        //fixme ?
        "stream": false,
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      logger.i(jsonDecode(data['response']));
      return jsonDecode(data['response']);
    } else {
      throw Exception('Failed to generate fitness plan');
    }
  }

  Future<Map<String, dynamic>> suggestReplacementExercise(WorkoutDay workoutDay, Exercise exerciseToReplace) async {
    var url = Uri.parse(apiUrl);
    var exerciceReplacementRequest = generateExerciseReplacementRequest(workoutDay, exerciseToReplace);
    logger.i(exerciceReplacementRequest);

    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "model": model,
        "prompt": exerciceReplacementRequest,
        //fixme ?
        "stream": false,
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      logger.i(jsonDecode(data['response']));
      return jsonDecode(data['response']);
    } else {
      throw Exception('Failed to fetch replacement exercise');
    }
  }

  String generateExerciseReplacementRequest(WorkoutDay workoutDay, Exercise exerciseToReplace) {
    Set<String> allAlreadySuggestedExercises = workoutDay.exercises.expand((exercise) => exercise.alreadySuggestedExercises).toSet();
    String excludedExercises = ([...workoutDay.exercises.map((exercise) => exercise.name), ...allAlreadySuggestedExercises]).join(', ');

    return '''
Please generate a replacement exercise for '${exerciseToReplace.name}' focusing on '${workoutDay.focusArea}'. The replacement exercise **must not** include any of the following exercises: [$excludedExercises].

### Important Notes:
- Your response **must** be in **valid JSON** format, without any extra explanations or text.
- Each field should follow this exact structure:
{
  "name": "Name of the new exercise as a string",
  "instruction": "Detailed instructions on how to perform the exercise. Use a single paragraph, clear and concise.",
  "sets": 3,  // **Sets must be a numeric value only** (e.g., 3, 4, etc.),
  "reps": "A string for reps or duration (e.g., '12 reps' or '30 seconds')"
}

### Additional Guidelines:
- The "sets" value should be a **whole number**, not a string.
- Ensure that the instruction is detailed enough to guide the user but avoid technical jargon.
- The exercise should focus on improving '${workoutDay.focusArea}'.

Please respond in valid JSON format only, with no additional text or explanations.
  ''';
  }
}

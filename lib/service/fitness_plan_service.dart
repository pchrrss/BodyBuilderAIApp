import 'package:bodybuilderaiapp/model/exercise.dart';
import 'package:bodybuilderaiapp/service/fitness_ai_http_service.dart';
import 'package:bodybuilderaiapp/service/firebase_firestore_http_service.dart';
import 'package:bodybuilderaiapp/model/fitness_plan_result.dart';
import 'package:bodybuilderaiapp/model/user_input_model.dart';

class FitnessPlanService {
  final FitnessAiHttpService _httpService = FitnessAiHttpService();
  final FirebaseFirestoreHttpService _firestoreService = FirebaseFirestoreHttpService();

  Future<FitnessPlanResult> fetchOrGenerateFitnessPlan(String userId, UserInputModel userInput) async {
    var existingPlan = await _firestoreService.fetchLatestFitnessPlan(userId);
    if (existingPlan != null) {
      return existingPlan;
    }

    return await _generateAndSavePlan(userId, userInput);
  }

  Future<FitnessPlanResult> regenerateFitnessPlan(String userId, UserInputModel userInput) async {
    return await _generateAndSavePlan(userId, userInput);
  }

  Future<FitnessPlanResult> _generateAndSavePlan(String userId, UserInputModel userInput) async {
    final fitnessPlanRequest = userInput.generateFitnessPlanRequest();
    var newPlan = await _httpService.generateFitnessPlan(fitnessPlanRequest);

    await _firestoreService.saveFitnessPlan(userId, newPlan);

    var latestPlan = await _firestoreService.fetchLatestFitnessPlan(userId);
    if (latestPlan == null) {
      throw Exception('Failed to generate and save fitness plan.');
    }
    return latestPlan;
  }

  Future<Exercise> changeExercise(String userId, String planId, String workoutDayId, Exercise exercise) async {
    var newExercise = await _httpService.suggestReplacementExercise("focusArea", exercise);
    return await _firestoreService.replaceExerciseInFirestore(userId, planId, workoutDayId, exercise.id, newExercise);
  }

  Future<void> markExerciseAsCompleted(String userId, String planId, String workoutDayId, String exerciseId) async {
    try {
      await _firestoreService.markExerciseAsCompleted(userId, planId, workoutDayId, exerciseId);
    } catch (e) {
      throw Exception('Failed to mark exercise as completed.');
    }
  }
}

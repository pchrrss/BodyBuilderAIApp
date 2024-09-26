import 'package:bodybuilderaiapp/service/fitness_plan_http_service.dart';
import 'package:bodybuilderaiapp/service/firebase_firestore_http_service.dart';
import 'package:bodybuilderaiapp/model/fitness_plan_result.dart';
import 'package:bodybuilderaiapp/model/user_input_model.dart';

class FitnessPlanService {
  final FitnessPlanHttpService _httpService = FitnessPlanHttpService();
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

    await _firestoreService.saveFitnessPlan(userId, newPlan.toJson());

    return newPlan;
  }
}

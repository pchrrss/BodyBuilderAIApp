import 'package:bodybuilderaiapp/model/fitness_plan_result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bodybuilderaiapp/model/user_input_model.dart';

class FirebaseFirestoreHttpService {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> saveUserInputs(String userId, UserInputModel userInput) async {
    await _usersCollection.doc(userId).set({
      'ageRange': userInput.ageRange ?? '',
      'bodyType': userInput.bodyType ?? '',
      'fitnessGoal': userInput.fitnessGoal ?? '',
      'bodyFatRange': userInput.bodyFatRange ?? '',
      'focusAreas': userInput.focusAreas?.toList() ?? [],
      'fitnessLevel': userInput.fitnessLevel ?? 1,
      'equipment': userInput.equipment ?? '',
      'workoutDays': userInput.workoutDays ?? 1,
    });
  }

  Future<UserInputModel?> loadUserInputs(String userId) async {
    final docUser = _usersCollection.doc(userId);
    final snapshot = await docUser.get();

    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      return UserInputModel(
        ageRange: data['ageRange'] as String?,
        bodyType: data['bodyType'] as String?,
        fitnessGoal: data['fitnessGoal'] as String?,
        bodyFatRange: data['bodyFatRange'] as String?,
        focusAreas: (data['focusAreas'] as List<dynamic>)
            .map((e) => e as String)
            .toSet(),
        fitnessLevel: data['fitnessLevel'] as int?,
        equipment: data['equipment'] as String?,
        workoutDays: data['workoutDays'] as int?,
      );
    } else {
      return null;
    }
  }

  Future<void> saveFitnessPlan(
      String userId, Map<String, dynamic> fitnessPlanData) async {
    await _usersCollection
        .doc(userId)
        .collection('fitnessPlans')
        .add({
          ...fitnessPlanData,
          'createdAt': FieldValue.serverTimestamp(),
        });
  }

  Future<FitnessPlanResult?> fetchLatestFitnessPlan(String userId) async {
    try {
      var snapshot = await _usersCollection
          .doc(userId)
          .collection('fitnessPlans')
          .orderBy('createdAt', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        var doc = snapshot.docs.first;
        return FitnessPlanResult.fromJson(doc.data());
      }
      return null;
    } catch (e) {
      throw Exception('Failed to fetch fitness plan from Firestore: $e');
    }
  }
}

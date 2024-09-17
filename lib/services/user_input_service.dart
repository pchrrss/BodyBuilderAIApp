import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bodybuilderaiapp/view/user_input/user_input_model.dart';

class UserInputService {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> saveUserInputs(String userId, UserInputModel userInput) async {
    await usersCollection.doc(userId).set({
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
    final docUser = usersCollection.doc(userId);
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
      String userId, Map<String, dynamic> fitnessPlan) async {
    await usersCollection
        .doc(userId)
        .collection('fitnessPlans')
        .add(fitnessPlan);
  }

  Future<List<Map<String, dynamic>>> loadFitnessPlans(String userId) async {
    QuerySnapshot querySnapshot = await usersCollection
        .doc(userId)
        .collection('fitnessPlans')
        .orderBy('createdAt', descending: true)
        .get();

    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }
}

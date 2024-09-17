import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bodybuilderaiapp/view/user_input/user_input_model.dart';

class UserInputService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveUserInputs(String userId, UserInputModel userInput) async {
    final docUser = _firestore.collection('users').doc(userId);

    await docUser.set({
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

  Future<UserInputModel> loadUserInputs(String userId) async {
    final docUser = _firestore.collection('users').doc(userId);
    final snapshot = await docUser.get();

    if (snapshot.exists) {
      final data = snapshot.data()!;
      return UserInputModel(
        ageRange: data['ageRange'] as String?,
        bodyType: data['bodyType'] as String?,
        fitnessGoal: data['fitnessGoal'] as String?,
        bodyFatRange: data['bodyFatRange'] as String?,
        focusAreas: (data['focusAreas'] as List<dynamic>).map((e) => e as String).toSet(),
        fitnessLevel: data['fitnessLevel'] as int?,
        equipment: data['equipment'] as String?,
        workoutDays: data['workoutDays'] as int?,
      );
    } else {
      return UserInputModel();
    }
  }
}

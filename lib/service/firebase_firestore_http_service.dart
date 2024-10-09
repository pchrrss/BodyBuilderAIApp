import 'package:bodybuilderaiapp/model/exercise.dart';
import 'package:bodybuilderaiapp/model/fitness_plan_result.dart';
import 'package:bodybuilderaiapp/model/workout_day.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bodybuilderaiapp/model/user_input_model.dart';

class FirebaseFirestoreHttpService {
  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('users');

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
        focusAreas: (data['focusAreas'] as List<dynamic>).map((e) => e as String).toSet(),
        fitnessLevel: data['fitnessLevel'] as int?,
        equipment: data['equipment'] as String?,
        workoutDays: data['workoutDays'] as int?,
      );
    } else {
      return null;
    }
  }

  Future<void> saveFitnessPlan(String userId, Map<String, dynamic> fitnessPlanData) async {
    final fitnessPlanDocRef = _usersCollection.doc(userId).collection('fitnessPlans').doc();

    fitnessPlanDocRef.set({
      'ageRange': fitnessPlanData['age_range'],
      'bodyType': fitnessPlanData['body_type'],
      'goal': fitnessPlanData['goal'],
      'bodyFatRange': fitnessPlanData['body_fat_range'],
      'fitnessLevel': fitnessPlanData['fitness_level'],
      'equipment': fitnessPlanData['equipment'],
      'workoutFrequencyPerWeek': fitnessPlanData['workout_frequency_per_week'],
      'createdAt': FieldValue.serverTimestamp(),
    });

    for (Map<String, dynamic> workoutDay in fitnessPlanData['workout_days']) {
      final workoutDayDocRef = fitnessPlanDocRef.collection('workoutDays').doc();

      await workoutDayDocRef.set({
        'day': workoutDay['day'],
        'focusArea': workoutDay['focus_area'],
      });

      for (Map<String, dynamic> exercise in workoutDay['exercises']) {
        final exerciseDocRef = workoutDayDocRef.collection('exercises').doc();

        await exerciseDocRef.set({
          'name': exercise['name'],
          'sets': exercise['sets'],
          'reps': exercise['reps'],
          'instruction': exercise['instruction'],
        });
      }
    }
  }

  Future<FitnessPlanResult?> fetchLatestFitnessPlan(String userId) async {
    try {
      final fitnessPlanQuery = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('fitnessPlans')
          .orderBy('createdAt', descending: true)
          .limit(1)
          .get();

      if (fitnessPlanQuery.docs.isEmpty) {
        print('No fitness plan available.');
        return null;
      }

      final fitnessPlanDoc = fitnessPlanQuery.docs.first;
      final workoutDaysQuery = await fitnessPlanDoc.reference.collection('workoutDays').orderBy('day').get();
      final workoutDays = await Future.wait(workoutDaysQuery.docs.map((dayDoc) async {
        final exercisesQuery = await dayDoc.reference.collection('exercises').get();

        final exercises = exercisesQuery.docs.map((exerciseDoc) {
          return Exercise.from(exerciseDoc.id, exerciseDoc.data());
        }).toList();

        return WorkoutDay.from(dayDoc.id, dayDoc.data(), exercises);
      }).toList());

      return FitnessPlanResult.from(fitnessPlanDoc.id, fitnessPlanDoc.data(), workoutDays);
    } catch (e) {
      print('Error fetching or processing fitness plan: $e');
      rethrow;
    }
  }

  Future<Exercise> replaceExerciseInFirestore(
      String userId, String fitnessPlanId, String workoutDayId, String exerciseId, Map<String, dynamic> newExerciseData) async {
    final exerciseRef = _usersCollection
        .doc(userId)
        .collection('fitnessPlans')
        .doc(fitnessPlanId)
        .collection('workoutDays')
        .doc(workoutDayId)
        .collection('exercises')
        .doc(exerciseId);

    var newExercise = Exercise.from(exerciseId, newExerciseData);

    await exerciseRef.set(newExercise.toJson());
    return newExercise;
  }

  Future<void> markExerciseAsCompleted(String userId, String planId, String workoutDayId, String exerciseId) async {
    DocumentReference exerciseDoc = _usersCollection
        .doc(userId)
        .collection('fitnessPlans')
        .doc(planId)
        .collection('workoutDays')
        .doc(workoutDayId)
        .collection('exercises')
        .doc(exerciseId);

    await exerciseDoc.update({
      'completed': true,
      'completedAt': FieldValue.serverTimestamp(),
    });
  }
}

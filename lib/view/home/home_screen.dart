import 'package:bodybuilderaiapp/service/firebase_firestore_http_service.dart';
import 'package:bodybuilderaiapp/service/fitness_ai_http_service.dart';
import 'package:flutter/material.dart';
import 'package:bodybuilderaiapp/model/fitness_plan_result.dart';
import 'package:bodybuilderaiapp/common_widget/transparent_app_bar_with_border.dart';
import 'package:bodybuilderaiapp/common/color_extension.dart';
import 'package:bodybuilderaiapp/model/user_input_model.dart';

class HomeScreen extends StatefulWidget {
  final String userId;
  final UserInputModel userInput;

  const HomeScreen({super.key, required this.userId, required this.userInput});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestoreHttpService _firebaseFirestoreHttpService = FirebaseFirestoreHttpService();
  final FitnessAiHttpService _fitnessAiHttpService = FitnessAiHttpService();
  Future<FitnessPlanResult?>? fitnessPlanFuture;
  Future<String>? motivationalSentenceFuture;

  @override
  void initState() {
    super.initState();
    fitnessPlanFuture = _firebaseFirestoreHttpService.fetchLatestFitnessPlan(widget.userId);
    motivationalSentenceFuture = _fitnessAiHttpService.fetchMotivationalSentence(widget.userInput);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      appBar: TransparentAppBarWithBorder(title: 'Home', userInput: widget.userInput),
      body: FutureBuilder<FitnessPlanResult?>(
        future: fitnessPlanFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            FitnessPlanResult fitnessPlan = snapshot.data!;
            return _buildPlanOverview(fitnessPlan);
          } else {
            return const Center(child: Text('No fitness plan available.'));
          }
        },
      ),
    );
  }

  Widget _buildPlanOverview(FitnessPlanResult fitnessPlan) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Center(
          child: fitnessPlan.areAllExercisesCompleted()
              ? Text(
                  'No active fitness plan. Why not start a new one?',
                  style: TextStyle(fontSize: 18, color: TColor.grey),
                )
              : Column(
                  children: [
                    Text(
                      'You have an active fitness plan!',
                      style: TextStyle(fontSize: 18, color: TColor.black),
                    ),
                    const SizedBox(height: 20),
                    _buildCircularProgressBar(fitnessPlan),
                    const SizedBox(height: 20),
                    _buildMotivationalSentence(),
                  ],
                )),
    );
  }

  Widget _buildCircularProgressBar(FitnessPlanResult fitnessPlan) {
    int totalDays = fitnessPlan.workoutDays.length;
    int completedDays = fitnessPlan.workoutDays.where((day) => day.exercises.every((exercise) => exercise.completed)).length;
    int totalExercises = fitnessPlan.workoutDays.fold(0, (sum, day) => sum + day.exercises.length);
    int completedExercises = fitnessPlan.workoutDays.fold(0, (sum, day) => sum + day.exercises.where((exercise) => exercise.completed).length);

    double progress = completedExercises / totalExercises;

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 150,
          width: 150,
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: 8.0,
            backgroundColor: Colors.grey[300],
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
          ),
        ),
        Column(
          children: [
            Text(
              '${(progress * 100).toStringAsFixed(1)}%',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: TColor.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$completedDays/$totalDays days completed',
              style: TextStyle(fontSize: 16, color: TColor.black),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildMotivationalSentence() {
    return FutureBuilder<String>(
      future: motivationalSentenceFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text(
            'Fetching some motivation...',
            style: TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return Text(
            snapshot.data!,
            style: const TextStyle(fontSize: 30, fontStyle: FontStyle.italic, color: Colors.black, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'Stay focused, you got this!',
            style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }
}

import 'package:bodybuilderaiapp/service/fitness_plan_service.dart';
import 'package:flutter/material.dart';
import 'package:bodybuilderaiapp/common_widget/fitness_loading_indicator.dart';
import 'package:bodybuilderaiapp/common_widget/transparent_app_bar_with_border.dart';
import 'package:bodybuilderaiapp/common/color_extension.dart';
import 'package:bodybuilderaiapp/model/user_input_model.dart';
import 'package:bodybuilderaiapp/model/fitness_plan_result.dart';

class FitnessPlanResultScreen extends StatefulWidget {
  final String userId;
  final UserInputModel userInput;

  const FitnessPlanResultScreen(
      {super.key, required this.userId, required this.userInput});

  @override
  State<FitnessPlanResultScreen> createState() =>
      _FitnessPlanResultScreenState();
}

class _FitnessPlanResultScreenState extends State<FitnessPlanResultScreen> {
  final FitnessPlanService _fitnessPlanService = FitnessPlanService();

  Future<FitnessPlanResult>? fitnessPlanFuture;

  @override
  void initState() {
    super.initState();
    fitnessPlanFuture =
        _fitnessPlanService.fetchOrGenerateFitnessPlan(widget.userId, widget.userInput);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      appBar: const TransparentAppBarWithBorder(title: 'Fitness Plan'),
      body: FutureBuilder<FitnessPlanResult>(
        future: fitnessPlanFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const FitnessLoadingIndicator();
          } else if (snapshot.hasError) {
            return _buildErrorState();
          } else if (snapshot.hasData) {
            FitnessPlanResult fitnessPlan = snapshot.data!;
            return _buildSuccessState(fitnessPlan);
          } else {
            return const Center(
              child: Text('No fitness plan available'),
            );
          }
        },
      ),
    );
  }

  Widget _buildSuccessState(FitnessPlanResult fitnessPlan) {
    return DefaultTabController(
      length: fitnessPlan.workoutPlan.length,
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            labelColor: TColor.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: TColor.primaryColor1,
            tabs: fitnessPlan.workoutPlan.map((dayPlan) {
              return Tab(text: dayPlan.day);
            }).toList(),
          ),
          Expanded(
            child: TabBarView(
              children: fitnessPlan.workoutPlan.map((dayPlan) {
                return _buildWorkoutDay(dayPlan);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutDay(WorkoutDay dayPlan) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: dayPlan.exercises.length,
        itemBuilder: (context, index) {
          final exercise = dayPlan.exercises[index];
          return _buildExerciseCard(exercise);
        },
      ),
    );
  }

  Widget _buildExerciseCard(Exercise exercise) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              exercise.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Sets: ${exercise.sets}, Reps: ${exercise.reps}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Failed to fetch fitness plan',
            style: TextStyle(color: Colors.red, fontSize: 18),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                fitnessPlanFuture =
                    _fitnessPlanService.fetchOrGenerateFitnessPlan(widget.userId, widget.userInput);
              });
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

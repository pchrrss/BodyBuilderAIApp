import 'package:bodybuilderaiapp/common_widget/exercise_list_item.dart';
import 'package:bodybuilderaiapp/model/exercise.dart';
import 'package:bodybuilderaiapp/model/workout_day.dart';
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

  const FitnessPlanResultScreen({super.key, required this.userId, required this.userInput});

  @override
  State<FitnessPlanResultScreen> createState() => _FitnessPlanResultScreenState();
}

class _FitnessPlanResultScreenState extends State<FitnessPlanResultScreen> {
  final FitnessPlanService _fitnessPlanService = FitnessPlanService();
  Future<FitnessPlanResult>? fitnessPlanFuture;

  @override
  void initState() {
    super.initState();
    fitnessPlanFuture = _fitnessPlanService.fetchOrGenerateFitnessPlan(widget.userId, widget.userInput);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      appBar: TransparentAppBarWithBorder(title: 'Fitness Plan', actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () {
            setState(() {
              fitnessPlanFuture = _fitnessPlanService.regenerateFitnessPlan(widget.userId, widget.userInput);
            });
          },
        ),
      ]),
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
      length: fitnessPlan.workoutDays.length,
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            labelColor: TColor.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: TColor.primaryColor1,
            tabs: fitnessPlan.workoutDays.map((dayPlan) {
              return Tab(text: dayPlan.day);
            }).toList(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TabBarView(
                children: fitnessPlan.workoutDays.map((dayPlan) {
                  return _buildWorkoutDay(fitnessPlan.id, dayPlan);
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutDay(String fitnessPlanId, WorkoutDay dayPlan) {
    return ListView.builder(
      itemCount: dayPlan.exercises.length,
      itemBuilder: (context, index) {
        final exercise = dayPlan.exercises[index];
        return ExerciseListItem(
          exercise: exercise,
          onComplete: () async {
            await _fitnessPlanService.markExerciseAsCompleted(
              widget.userId,
              fitnessPlanId,
              dayPlan.id,
              exercise.id,
            );
            setState(() {
              exercise.completed = true;
            });
          },
          onChangeExercise: () async {
            var newExercise = await _fitnessPlanService.changeExercise(
              widget.userId,
              fitnessPlanId,
              dayPlan.id,
              exercise,
            );
            setState(() {
              dayPlan.exercises[index] = newExercise;
            });
          },
        );
      },
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
                fitnessPlanFuture = _fitnessPlanService.fetchOrGenerateFitnessPlan(widget.userId, widget.userInput);
              });
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  void _replaceExercise(Exercise exercise) {}
}

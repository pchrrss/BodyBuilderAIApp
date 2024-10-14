import 'package:bodybuilderaiapp/common_widget/exercise_list_item.dart';
import 'package:bodybuilderaiapp/common_widget/typing_effect_loading_screen.dart';
import 'package:bodybuilderaiapp/common_widget/workout_day_progress.dart';
import 'package:bodybuilderaiapp/model/workout_day.dart';
import 'package:bodybuilderaiapp/service/firebase_firestore_http_service.dart';
import 'package:bodybuilderaiapp/service/fitness_plan_service.dart';
import 'package:flutter/material.dart';
import 'package:bodybuilderaiapp/common_widget/transparent_app_bar_with_border.dart';
import 'package:bodybuilderaiapp/common/color_extension.dart';
import 'package:bodybuilderaiapp/model/user_input_model.dart';
import 'package:bodybuilderaiapp/model/fitness_plan_result.dart';
import 'package:logger/web.dart';

class FitnessPlanResultScreen extends StatefulWidget {
  final String userId;
  final UserInputModel userInput;

  const FitnessPlanResultScreen({super.key, required this.userId, required this.userInput});

  @override
  State<FitnessPlanResultScreen> createState() => _FitnessPlanResultScreenState();
}

class _FitnessPlanResultScreenState extends State<FitnessPlanResultScreen> {
  Logger log = Logger();
  final FitnessPlanService _fitnessPlanService = FitnessPlanService();
  final FirebaseFirestoreHttpService _firestoreService = FirebaseFirestoreHttpService();
  Future<FitnessPlanResult>? fitnessPlanFuture;
  List<String> favoriteExerciseNames = [];
  int currentDayIndex = 0;
  bool allExercisesCompleted = false;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
    fitnessPlanFuture = _fitnessPlanService.fetchOrGenerateFitnessPlan(widget.userId, widget.userInput);
    fitnessPlanFuture!.then((fitnessPlan) {
      setState(() {
        currentDayIndex = fitnessPlan.findFirstUncompletedDay();
        allExercisesCompleted = fitnessPlan.areAllExercisesCompleted();
      });
    });
  }

  Future<void> _loadFavorites() async {
    var favoriteExercises = await _firestoreService.getLikedExercises(widget.userId);
    setState(() {
      favoriteExerciseNames = favoriteExercises.map((fav) => fav.name).toList();
      log.i('Favorite exercises: $favoriteExerciseNames');
    });
  }

  void _goToNextDay(FitnessPlanResult fitnessPlan) {
    if (currentDayIndex < fitnessPlan.workoutDays.length - 1) {
      setState(() {
        currentDayIndex++;
      });
    }
  }

  Future<void> _regeneratePlan() async {
    setState(() {
      currentDayIndex = 0;
      allExercisesCompleted = false;
      fitnessPlanFuture = _fitnessPlanService.regenerateFitnessPlan(widget.userId, widget.userInput);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      appBar: TransparentAppBarWithBorder(title: 'Fitness Plan', userInput: widget.userInput, actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => _regeneratePlan(),
        ),
      ]),
      body: FutureBuilder<FitnessPlanResult>(
        future: fitnessPlanFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return TypingEffectLoadingScreen();
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
    WorkoutDay dayPlan = fitnessPlan.workoutDays[currentDayIndex];
    return Column(
      children: [
        WorkoutDayProgress(workoutDay: dayPlan),
        Expanded(
          child: ListView.builder(
            itemCount: dayPlan.exercises.length,
            itemBuilder: (context, index) {
              final exercise = dayPlan.exercises[index];
              return ExerciseListItem(
                exercise: exercise,
                isLiked: favoriteExerciseNames.contains(exercise.name),
                onComplete: () async {
                  await _fitnessPlanService.markExerciseAsCompleted(
                    widget.userId,
                    fitnessPlan.id,
                    dayPlan.id,
                    exercise.id,
                  );
                  setState(() {
                    exercise.completed = true;
                    allExercisesCompleted = fitnessPlan.areAllExercisesCompleted();
                    if (allExercisesCompleted) {
                      currentDayIndex = fitnessPlan.findFirstUncompletedDay();
                    }
                  });
                },
                onChangeExercise: () async {
                  var newExercise = await _fitnessPlanService.changeExercise(
                    widget.userId,
                    fitnessPlan.id,
                    dayPlan,
                    exercise,
                  );
                  setState(() {
                    dayPlan.exercises[index] = newExercise;
                  });
                },
                onLikeExercise: () async {
                  await _firestoreService.likeExercise(widget.userId, exercise);
                  setState(() {
                    favoriteExerciseNames.add(exercise.name);
                  });
                },
                onUnlikeExercise: () async {
                  await _firestoreService.unlikeExercise(widget.userId, exercise);
                  setState(() {
                    favoriteExerciseNames.remove(exercise.name);
                  });
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: currentDayIndex > 0 ? () => setState(() => currentDayIndex--) : null,
                child: const Text('Previous Day'),
              ),
              ElevatedButton(
                onPressed: currentDayIndex < fitnessPlan.workoutDays.length - 1
                    ? () => _goToNextDay(fitnessPlan)
                    : (allExercisesCompleted ? () => _regeneratePlan() : null),
                child: Text(allExercisesCompleted && currentDayIndex == fitnessPlan.workoutDays.length - 1 ? 'Regenerate Plan' : 'Next Day'),
              ),
            ],
          ),
        ),
      ],
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
}

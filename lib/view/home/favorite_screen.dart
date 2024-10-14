import 'package:bodybuilderaiapp/common_widget/favorite_exercise_list_item.dart';
import 'package:bodybuilderaiapp/common_widget/transparent_app_bar_with_border.dart';
import 'package:bodybuilderaiapp/model/favorite_exercise.dart';
import 'package:bodybuilderaiapp/model/user_input_model.dart';
import 'package:bodybuilderaiapp/service/firebase_firestore_http_service.dart';
import 'package:flutter/material.dart';
import 'package:bodybuilderaiapp/common/color_extension.dart';

class FavoriteScreen extends StatefulWidget {
  final String userId;
  final UserInputModel userInput;

  const FavoriteScreen({super.key, required this.userId, required this.userInput});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final FirebaseFirestoreHttpService _firestoreService = FirebaseFirestoreHttpService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      appBar: TransparentAppBarWithBorder(title: 'Favorite', userInput: widget.userInput),
      body: FutureBuilder<List<FavoriteExercise>>(
        future: _firestoreService.getLikedExercises(widget.userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            var exercises = snapshot.data!;
            return ListView.builder(
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                var exercise = exercises[index];
                return FavoriteExerciseListItem(
                  exercise: exercise,
                  onLikeExercise: () async {
                    await _firestoreService.likeExercise(widget.userId, exercise);
                  },
                  onUnlikeExercise: () async {
                    await _firestoreService.unlikeExercise(widget.userId, exercise);
                    setState(() {
                      exercises.removeAt(index);
                    });
                  },
                );
              },
            );
          } else {
            return const Center(child: Text('No favorite exercises found'));
          }
        },
      ),
    );
  }
}

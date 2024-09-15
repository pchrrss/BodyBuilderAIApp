import 'package:bodybuilderaiapp/view/user_input/user_input_model.dart';
import 'package:flutter/material.dart';
import 'package:bodybuilderaiapp/common/color_extension.dart';

class FavoriteScreen extends StatefulWidget {
  final UserInputModel userInput;

  const FavoriteScreen({super.key, required this.userInput});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  Future<Map<String, dynamic>> fetchFitnessPlan() async {

    await Future.delayed(Duration(seconds: 3));
    return {
      'plan': '4-Day Strength and Cardio',
      'exercises': [
        {'name': 'Squats', 'reps': '3 sets of 12'},
        {'name': 'Push-ups', 'reps': '3 sets of 15'},
        {'name': 'Planks', 'reps': '3 sets of 60 seconds'},
      ],
      'duration': '6 weeks',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchFitnessPlan(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Failed to fetch data',
                style: TextStyle(color: Colors.red),
              ),
            );
          } else if (snapshot.hasData) {
            var fitnessPlan = snapshot.data!;
            var exercises = fitnessPlan['exercises'] as List<dynamic>;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Plan: ${fitnessPlan['plan']}',
                    style: TextStyle(
                      color: TColor.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Duration: ${fitnessPlan['duration']}',
                    style: TextStyle(
                      color: TColor.grey,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 20),


                  Expanded(
                    child: ListView.builder(
                      itemCount: exercises.length,
                      itemBuilder: (context, index) {
                        var exercise = exercises[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            leading: Icon(Icons.fitness_center, color: TColor.primaryColor1),
                            title: Text(exercise['name']),
                            subtitle: Text(exercise['reps']),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text('No data available'),
            );
          }
        },
      ),
    );
  }
}

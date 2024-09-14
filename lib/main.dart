import 'package:bodybuilderaiapp/common/color_extension.dart';
import 'package:bodybuilderaiapp/view/on_boarding/started_view.dart';
import 'package:bodybuilderaiapp/view/user_input/age_input_screen.dart';
import 'package:bodybuilderaiapp/view/user_input/fitness_goal_input_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Body Builder AI',
      theme: ThemeData(
        primaryColor: TColor.primaryColor1,
        useMaterial3: true,
        fontFamily: "NotoSans",
      ),
      home: const FitnessGoalInputScreen()
    );
  }
}

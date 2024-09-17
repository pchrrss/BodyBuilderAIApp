import 'package:bodybuilderaiapp/services/user_input_service.dart';
import 'package:bodybuilderaiapp/view/home/fitness_plan_result_screen.dart';
import 'package:bodybuilderaiapp/view/home/main_app_with_navigation.dart';
import 'package:bodybuilderaiapp/view/login/login_view.dart';
import 'package:bodybuilderaiapp/view/on_boarding/started_view.dart';
import 'package:bodybuilderaiapp/view/user_input/user_input_model.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:flutter/material.dart';

class AuthGuard extends StatelessWidget {
  const AuthGuard({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const LoginView();
        }
        final user = snapshot.data!;
        final userId = user.uid;

        return FutureBuilder<UserInputModel>(
          future: UserInputService().loadUserInputs(userId),
          builder: (context, userInputSnapshot) {
            if (userInputSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (userInputSnapshot.hasError) {
              return const Center(child: Text('Error loading user data'));
            } else if (userInputSnapshot.hasData) {
              return MainAppWithNavigation(userId: userId, userInput: userInputSnapshot.data!);
            } else {
              return const StartedView();
            }
          },
        );
      },
    );
  }
}

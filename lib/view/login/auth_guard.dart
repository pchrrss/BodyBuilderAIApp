import 'package:bodybuilderaiapp/view/login/login_view.dart';
import 'package:bodybuilderaiapp/view/on_boarding/started_view.dart';
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
        return const StartedView();
      },
    );
  }
}

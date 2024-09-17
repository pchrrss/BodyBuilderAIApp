import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      providers: [
        EmailAuthProvider(),
        GoogleProvider(clientId: dotenv.env['GOOGLE_CLIENT_ID']!)
      ],
      showPasswordVisibilityToggle: true,
      headerBuilder: (context, constraints, shrinkOffset) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Image.asset('assets/img/logo.png', fit: BoxFit.fitHeight),
        );
      },
      subtitleBuilder: (context, action) {
        return action == AuthAction.signIn
            ? const Text(
                'Sign in to continue',
                style: TextStyle(
                  fontSize: 16,
                ),
              )
            : const Text(
                'Sign up to continue',
                style: TextStyle(
                  fontSize: 16,
                ),
              );
      },
      footerBuilder: (context, action) {
        return const Padding(
          padding: EdgeInsets.only(top: 16),
          child: Text(
            'By signing in, you agree to our terms and conditions.',
            style: TextStyle(color: Colors.grey),
          ),
        );
      },
    );
  }
}

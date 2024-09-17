import 'package:bodybuilderaiapp/view/login/auth_guard.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileScreen(
      actions: [
        SignedOutAction((context) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AuthGuard()));
        })
      ]);
  }
}
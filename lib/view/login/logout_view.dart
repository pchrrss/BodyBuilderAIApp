import 'package:bodybuilderaiapp/view/login/auth_guard.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class LogoutView extends StatelessWidget {
  const LogoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileScreen(
      appBar: AppBar(
        title: const Text("Logout"),
      ),
      actions: [
        SignedOutAction((context) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AuthGuard()));
        })
      ]);
  }
}
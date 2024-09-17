import 'package:bodybuilderaiapp/common/color_extension.dart';
import 'package:bodybuilderaiapp/firebase_options.dart';
import 'package:bodybuilderaiapp/view/login/auth_guard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Body Builder AI',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: TColor.primaryColor1,
          scaffoldBackgroundColor: TColor.white,
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              
            ),
          ),
          outlinedButtonTheme: const OutlinedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll<Color>(Colors.blue),
              foregroundColor: WidgetStatePropertyAll<Color>(Colors.white),
            )
          ),
          useMaterial3: true,
          fontFamily: "NotoSans",
        ),
        home: const AuthGuard());
  }
}

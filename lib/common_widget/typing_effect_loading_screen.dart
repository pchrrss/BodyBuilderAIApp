import 'dart:async';
import 'package:bodybuilderaiapp/common_widget/fitness_loading_indicator.dart';
import 'package:flutter/material.dart';

class TypingEffectLoadingScreen extends StatefulWidget {
  const TypingEffectLoadingScreen({super.key});

  @override
  State<TypingEffectLoadingScreen> createState() => _TypingEffectLoadingScreenState();
}

class _TypingEffectLoadingScreenState extends State<TypingEffectLoadingScreen> {
  List<String> sentences = [
    "The AI is thinking really hard...",
    "Maybe the AI is getting a coffee break?",
    "Don’t worry, the AI will be back... eventually!",
    "Just another few trillion calculations!",
    "Your fitness plan is being bench-pressed by the AI!",
    "AI is warming up... almost ready for the workout!",
    "The AI is flexing its muscles... generating your plan!",
    "Your plan is doing squats in the cloud!",
    "AI is running laps to deliver your workout.",
    "The AI is sweating it out for the perfect plan.",
    "Hold on, the AI is doing a cool-down stretch.",
    "The AI is fueled by a MacBook... give it a second.",
    "The AI is taking a quick break... MacBooks aren't known for sprinting.",
    "AI on a MacBook: slower than leg day, but just as effective!",
    "Be patient, this MacBook needs to stop for water breaks."
  ];

  String currentSentence = "";
  int sentenceIndex = 0;
  String displayedText = "";
  int textIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    sentences.shuffle();
    _startTyping();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTyping() {
    setState(() {
      currentSentence = sentences[sentenceIndex];
    });

    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (!mounted) return;

      if (textIndex < currentSentence.length) {
        setState(() {
          displayedText += currentSentence[textIndex];
          textIndex++;
        });
      } else {
        timer.cancel();
        _showNextSentence();
      }
    });
  }

  void _showNextSentence() {
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      setState(() {
        sentenceIndex = (sentenceIndex + 1) % sentences.length;
        displayedText = "";
        textIndex = 0;
      });
      _startTyping();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FitnessLoadingIndicator(),
              const SizedBox(height: 20),
              Text(
                displayedText,
                style: const TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

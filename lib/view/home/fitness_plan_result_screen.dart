import 'package:bodybuilderaiapp/common_widget/fitness_loading_indicator.dart';
import 'package:bodybuilderaiapp/services/auth_service.dart';
import 'package:bodybuilderaiapp/services/user_input_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bodybuilderaiapp/view/user_input/user_input_model.dart';
import 'package:bodybuilderaiapp/common/color_extension.dart';
import 'package:bodybuilderaiapp/services/api_service.dart';

class FitnessPlanResultScreen extends StatefulWidget {
  final String userId;
  final UserInputModel userInput;

  const FitnessPlanResultScreen(
      {super.key, required this.userId, required this.userInput});

  @override
  State<FitnessPlanResultScreen> createState() =>
      _FitnessPlanResultScreenState();
}

class _FitnessPlanResultScreenState extends State<FitnessPlanResultScreen> {
  final UserInputService _userInputService = UserInputService();

  Future<String>? fitnessPlanFuture;

  @override
  void initState() {
    super.initState();
    fitnessPlanFuture = _fetchOrGenerateFitnessPlan();
  }

  Future<String> _fetchOrGenerateFitnessPlan() async {
    try {
      final existingPlans =
          await _userInputService.loadFitnessPlans(widget.userId);
      if (existingPlans.isNotEmpty) {
        return existingPlans.first['plan'];
      } else {
        return _generateAndSavePlan();
      }
    } catch (e) {
      _showErrorSnackBar('Failed to fetch fitness plan');
      throw Exception('Error loading/generating plan: $e');
    }
  }

  Future<String> _generateAndSavePlan() async {
    try {
      final newPlan = await ApiService.generateFitnessPlan(widget.userInput);
      _savePlan(newPlan);
      return newPlan;
    } catch (e) {
      _showErrorSnackBar('Failed to generate fitness plan');
      throw Exception('Error generating plan: $e');
    }
  }

  void _savePlan(String fitnessPlan) async {
    try {
      final fitnessPlanData = {
        'plan': fitnessPlan,
        'createdAt': FieldValue.serverTimestamp(),
      };
      await _userInputService.saveFitnessPlan(widget.userId, fitnessPlanData);
    } catch (e) {
      _showErrorSnackBar('Failed to save fitness plan: $e');
    }
  }

  void _regenerateFitnessPlan() async {
    setState(() {
      fitnessPlanFuture = _generateAndSavePlan();
    });
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      appBar: AppBar(
        title: const Text("Fitness Plan"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _regenerateFitnessPlan,
            tooltip: 'Regenerate Plan',
          )
        ],
      ),
      body: FutureBuilder<String>(
        future: fitnessPlanFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const FitnessLoadingIndicator();
          } else if (snapshot.hasError) {
            return _buildErrorState();
          } else if (snapshot.hasData) {
            String fitnessPlan = snapshot.data!;
            return _buildSuccessState(fitnessPlan);
          } else {
            return const Center(
              child: Text('No fitness plan available'),
            );
          }
        },
      ),
    );
  }

  Widget _buildSuccessState(String fitnessPlan) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Generated Fitness Plan:',
            style: TextStyle(
              color: TColor.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                fitnessPlan,
                style: TextStyle(
                  color: TColor.grey,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Failed to fetch fitness plan',
            style: TextStyle(color: Colors.red, fontSize: 18),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                fitnessPlanFuture = _fetchOrGenerateFitnessPlan();
              });
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

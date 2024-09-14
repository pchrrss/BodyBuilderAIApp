import 'package:flutter/material.dart';
import 'package:bodybuilderaiapp/view/user_input/user_input_model.dart';
import 'package:bodybuilderaiapp/common/color_extension.dart';
import 'package:bodybuilderaiapp/services/api_service.dart';  // Import your ApiService

class FitnessPlanResultScreen extends StatefulWidget {
  final UserInputModel userInput;

  const FitnessPlanResultScreen({super.key, required this.userInput});

  @override
  State<FitnessPlanResultScreen> createState() => _FitnessPlanResultScreenState();
}

class _FitnessPlanResultScreenState extends State<FitnessPlanResultScreen> {
  Future<String> fetchFitnessPlan() async {
    try {
      String fitnessPlan = await ApiService.generateFitnessPlan(widget.userInput);
      return fitnessPlan;
    } catch (e) {
      throw Exception('Failed to fetch fitness plan');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      
      body: FutureBuilder<String>(
        future: fetchFitnessPlan(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Failed to fetch fitness plan',
                style: TextStyle(color: Colors.red),
              ),
            );
          } else if (snapshot.hasData) {

            String fitnessPlan = snapshot.data!;
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
                  SizedBox(height: 10),
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
          } else {
            return Center(
              child: Text('No fitness plan available'),
            );
          }
        },
      ),
    );
  }
}

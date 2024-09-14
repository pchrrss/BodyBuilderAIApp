import 'package:bodybuilderaiapp/view/home/fitness_plan_result_screen.dart';
import 'package:bodybuilderaiapp/view/user_input/user_input_model.dart';
import 'package:flutter/material.dart';
import 'package:bodybuilderaiapp/common/color_extension.dart';
import 'package:bodybuilderaiapp/common_widget/round_button.dart';

class FitnessDetailsInputScreen extends StatefulWidget {
  final UserInputModel userInput;

  const FitnessDetailsInputScreen({super.key, required this.userInput});

  @override
  State<FitnessDetailsInputScreen> createState() =>
      _FitnessDetailsInputScreenState();
}

class _FitnessDetailsInputScreenState extends State<FitnessDetailsInputScreen> {
  String? selectedAgeRange;
  String? selectedBodyFatRange;
  String? selectedEquipment;
  double fitnessLevel = 1;
  double workoutDays = 1;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: TColor.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: media.width * 0.05),
              Text(
                "Your Fitness Details",
                style: TextStyle(
                  color: TColor.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: media.width * 0.05),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Age Range",
                  border: OutlineInputBorder(),
                ),
                value: selectedAgeRange,
                items: UserInputModel.ageRangeOptions.map((ageRange) {
                  return DropdownMenuItem(
                    value: ageRange,
                    child: Text(
                      ageRange,
                      style: TextStyle(
                          color: TColor.black, backgroundColor: TColor.white),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedAgeRange = value;
                  });
                },
              ),
              SizedBox(height: media.width * 0.1),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Body Fat Range",
                  border: OutlineInputBorder(),
                ),
                value: selectedBodyFatRange,
                items: UserInputModel.bodyFatRangeOptions.map((bodyFatRange) {
                  return DropdownMenuItem(
                    value: bodyFatRange,
                    child: Text(bodyFatRange),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedBodyFatRange = value;
                  });
                },
              ),
              SizedBox(height: media.width * 0.1),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Available Equipment",
                  border: OutlineInputBorder(),
                ),
                value: selectedEquipment,
                items: UserInputModel.equipmentOptions.map((equipment) {
                  return DropdownMenuItem(
                    value: equipment,
                    child: Text(equipment),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedEquipment = value;
                  });
                },
              ),
              SizedBox(height: media.width * 0.1),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Fitness Level (1-10)",
                    style: TextStyle(
                      color: TColor.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Slider(
                    value: fitnessLevel,
                    min: 1,
                    max: 10,
                    divisions: 9,
                    label: fitnessLevel.round().toString(),
                    onChanged: (value) {
                      setState(() {
                        fitnessLevel = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: media.width * 0.1),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Workout Days per Week (1-7)",
                    style: TextStyle(
                      color: TColor.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Slider(
                    value: workoutDays,
                    min: 1,
                    max: 7,
                    divisions: 6,
                    label: workoutDays.round().toString(),
                    onChanged: (value) {
                      setState(() {
                        workoutDays = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: media.width * 0.1),
              const Spacer(),
              RoundButton(
                title: "Confirm",
                onPressed: () {
                  widget.userInput.ageRange = selectedAgeRange;
                  widget.userInput.bodyFatRange = selectedBodyFatRange;
                  widget.userInput.equipment = selectedEquipment;
                  widget.userInput.fitnessLevel = fitnessLevel.round();
                  widget.userInput.workoutDays = workoutDays.round();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          FitnessPlanResultScreen(userInput: widget.userInput),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

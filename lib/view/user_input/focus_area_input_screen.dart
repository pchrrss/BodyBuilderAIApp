import 'package:bodybuilderaiapp/common/color_extension.dart';
import 'package:bodybuilderaiapp/common_widget/round_button.dart';
import 'package:bodybuilderaiapp/view/user_input/user_input_model.dart';
import 'package:flutter/material.dart';

class FocusAreaInputScreen extends StatefulWidget {
  final UserInputModel userInput;
  const FocusAreaInputScreen({super.key, required this.userInput});

  @override
  State<FocusAreaInputScreen> createState() => _FocusAreaInputScreenState();
}

class _FocusAreaInputScreenState extends State<FocusAreaInputScreen> {
  List focusAreas = [
    {
      "image": "assets/img/focus_legs.png",
      "title": "Legs",
      "subTitle": "Strengthen and tone your lower body."
    },
    {
      "image": "assets/img/focus_belly.png",
      "title": "Belly",
      "subTitle": "Sculpt and define your core."
    },
    {
      "image": "assets/img/focus_arms.png",
      "title": "Arms",
      "subTitle": "Build strength and muscle in your arms."
    },
    {
      "image": "assets/img/focus_chest.png",
      "title": "Chest",
      "subTitle": "Enhance and shape your chest muscles."
    },
    {
      "image": "assets/img/focus_back.png",
      "title": "Back",
      "subTitle": "Improve posture and back strength."
    },
    {
      "image": "assets/img/focus_fullbody.png",
      "title": "Full Body",
      "subTitle": "Train your entire body for overall fitness."
    },
  ];

  Set<int> selectedFocusAreas = {};

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
                "What's your focus area?",
                style: TextStyle(
                  color: TColor.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "You can select multiple areas",
                style: TextStyle(
                  color: TColor.grey,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: media.width * 0.05),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.90,
                  ),
                  itemCount: focusAreas.length,
                  itemBuilder: (context, index) {
                    var focusArea = focusAreas[index];
                    bool isSelected = selectedFocusAreas.contains(index);

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            selectedFocusAreas.remove(index);
                          } else {
                            selectedFocusAreas.add(index);
                          }
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: isSelected
                                ? [TColor.secondaryColor1, TColor.primaryColor1]
                                : TColor.primaryGradient,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(25),
                          border: isSelected
                              ? Border.all(color: TColor.grey, width: 3)
                              : Border.all(color: Colors.transparent, width: 3),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: media.width * 0.07,
                          horizontal: 25,
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              focusArea["image"],
                              width: media.width * 0.3,
                              fit: BoxFit.fitWidth,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              focusArea["title"],
                              style: TextStyle(
                                color: TColor.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              focusArea["subTitle"],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: TColor.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: RoundButton(
                  title: "Confirm",
                  onPressed: () {
                    widget.userInput.focusAreas = selectedFocusAreas
                        .map((index) => focusAreas[index]["title"].toString())
                        .toSet();
                    print(widget.userInput);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

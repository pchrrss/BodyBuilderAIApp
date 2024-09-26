import 'package:bodybuilderaiapp/common/color_extension.dart';
import 'package:bodybuilderaiapp/common_widget/round_button.dart';
import 'package:bodybuilderaiapp/common_widget/slider_card.dart';
import 'package:bodybuilderaiapp/view/user_input/body_type_input_screen.dart';
import 'package:bodybuilderaiapp/model/user_input_model.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class FitnessGoalInputScreen extends StatefulWidget {
  const FitnessGoalInputScreen({super.key});

  @override
  State<FitnessGoalInputScreen> createState() => _FitnessGoalInputScreenState();
}

class _FitnessGoalInputScreenState extends State<FitnessGoalInputScreen> {
  CarouselSliderController buttonCarouselController =
      CarouselSliderController();
  int selectedGoalIndex = 0;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: TColor.white,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: CarouselSlider(
                items: UserInputModel.fitnessGoalOptions.asMap().entries.map((entry) {
                  int index = entry.key;
                  var goal = entry.value;
                  return SliderCard(
                    image: goal["image"]!,
                    title: goal["title"]!,
                    subTitle: goal["subTitle"]!,
                    isSelected: selectedGoalIndex == index,
                    onTap: () {
                      setState(() {
                        selectedGoalIndex = index;
                      });
                    },
                  );
                }).toList(),
                carouselController: buttonCarouselController,
                options: CarouselOptions(
                  autoPlay: false,
                  enlargeCenterPage: true,
                  viewportFraction: 0.75,
                  aspectRatio: 0.75,
                  onPageChanged: (index, reason) {
                    setState(() {
                      selectedGoalIndex = index;
                    });
                  },
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  SizedBox(height: media.width * 0.05),
                  Text(
                    "What's your fitness goal?",
                    style: TextStyle(
                      color: TColor.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "It will help us choose the right plan for you",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: TColor.grey, fontSize: 12),
                  ),
                  const Spacer(),
                  RoundButton(
                    title: "Confirm",
                    onPressed: () {
                      String selectedGoal = UserInputModel.fitnessGoalOptions[selectedGoalIndex]["title"]!;
                      
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BodyTypeInputScreen(userInput: UserInputModel(fitnessGoal: selectedGoal)),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:bodybuilderaiapp/common/color_extension.dart';
import 'package:bodybuilderaiapp/common_widget/round_button.dart';
import 'package:bodybuilderaiapp/view/login/welcome_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class WhatYourGoalView extends StatefulWidget {
  const WhatYourGoalView({super.key});

  @override
  State<WhatYourGoalView> createState() => _WhatYourGoalViewState();
}

class _WhatYourGoalViewState extends State<WhatYourGoalView> {
  CarouselSliderController buttonCarouselController =
      CarouselSliderController();
  
  List goals = [
    {"image": "assets/img/goals/cardio.webp", "title": "Lose Weight", "subTitle": "Achieve a leaner physique with a targeted approach."},
    {"image": "", "title": "Gain Muscle", "subTitle": "Strengthen and grow your muscles with focused training."},
    {"image": "", "title": "Get Shredded", "subTitle": "Carve out defined muscles with precision workouts."},
    {"image": "", "title": "Maintain Fitness", "subTitle": "Stay in peak condition with balanced routines."},
  ];

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
                  items: goals
                      .map((gObj) => Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: TColor.primaryGradient,
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: media.width * 0.07, horizontal: 25),
                            alignment: Alignment.center,
                            child: FittedBox(
                              child: Column(
                                children: [
                                  Image.asset(
                                    gObj["image"],
                                    width: media.width * 0.5,
                                    fit: BoxFit.fitWidth,
                                  ),
                                  SizedBox(height: media.width * 0.1),
                                  Text(
                                    gObj["title"],
                                    style: TextStyle(
                                        color: TColor.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    width: media.width * 0.1,
                                    height: 1,
                                    color: TColor.white,
                                  ),
                                  SizedBox(height: media.width * 0.02),
                                  Text(
                                    gObj["subTitle"],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: TColor.white, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                  carouselController: buttonCarouselController,
                  options: CarouselOptions(
                    autoPlay: false,
                    enlargeCenterPage: true,
                    viewportFraction: 0.75,
                    aspectRatio: 0.75,
                    initialPage: 0,
                  )),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  SizedBox(height: media.width * 0.05),
                  Text(
                    "What's your goal?",
                    style: TextStyle(
                        color: TColor.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "It will help us to choose the right plan for you",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: TColor.grey, fontSize: 12),
                  ),
                  const Spacer(),
                  SizedBox(height: media.width * 0.05),
                  RoundButton(
                    title: "Confirm",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WelcomeView()));
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

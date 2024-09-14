import 'package:bodybuilderaiapp/common/color_extension.dart';
import 'package:bodybuilderaiapp/common_widget/round_button.dart';
import 'package:bodybuilderaiapp/common_widget/slider_card.dart';
import 'package:bodybuilderaiapp/view/user_input/focus_area_input_screen.dart';
import 'package:bodybuilderaiapp/view/user_input/user_input_model.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class BodyTypeInputScreen extends StatefulWidget {
  final UserInputModel userInput;
  const BodyTypeInputScreen({super.key, required this.userInput});

  @override
  State<BodyTypeInputScreen> createState() => _BodyTypeInputScreenState();
}

class _BodyTypeInputScreenState extends State<BodyTypeInputScreen> {
  CarouselSliderController buttonCarouselController = CarouselSliderController();
  int selectedBodyTypeIndex = 0;

  List bodyTypes = [
    {"image": "assets/img/bodytypes/slim.png", "title": "Slim", "subTitle": "A lean and toned figure with a slender build."},
    {"image": "assets/img/bodytypes/average.png", "title": "Average", "subTitle": "A balanced figure with moderate muscle and body fat."},
    {"image": "assets/img/bodytypes/heavy.png", "title": "Heavy", "subTitle": "A stockier, broader figure with higher body mass and fat."},
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
                items: bodyTypes.asMap().entries.map((entry) {
                  int index = entry.key;
                  var bodyType = entry.value;
                  return SliderCard(
                    image: bodyType["image"]!,
                    title: bodyType["title"]!,
                    subTitle: bodyType["subTitle"]!,
                    isSelected: selectedBodyTypeIndex == index,
                    onTap: () {
                      setState(() {
                        selectedBodyTypeIndex = index;
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
                      selectedBodyTypeIndex = index;
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
                    "What's your body type?",
                    style: TextStyle(
                      color: TColor.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "It will help us customize your fitness plan",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: TColor.grey, fontSize: 12),
                  ),
                  const Spacer(),
                  RoundButton(
                    title: "Confirm",
                    onPressed: () {
                      widget.userInput.bodyType = bodyTypes[selectedBodyTypeIndex]["title"]!;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FocusAreaInputScreen(userInput: widget.userInput),
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

import 'package:bodybuilderaiapp/common/color_extension.dart';
import 'package:bodybuilderaiapp/common_widget/round_button.dart';
import 'package:bodybuilderaiapp/view/on_boarding/on_boarding_view.dart';
import 'package:bodybuilderaiapp/view/user_input/fitness_goal_input_screen.dart';
import 'package:flutter/material.dart';

class StartedView extends StatefulWidget {
  const StartedView({super.key});

  @override
  State<StartedView> createState() => _StartedViewState();
}

class _StartedViewState extends State<StartedView> {
  bool isChangeColor = true;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: TColor.white,
        body: Container(
            width: media.width,
            decoration: BoxDecoration(
                gradient: isChangeColor
                    ? LinearGradient(
                        colors: TColor.primaryGradient,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight)
                    : null),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Text("Body Builder AI",
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: isChangeColor ? TColor.white : TColor.black)),
                Text(
                  "Get your body in shape with our AI",
                  style: TextStyle(fontSize: 18, color: isChangeColor ? TColor.white : TColor.black),
                ),
                const Spacer(),
                SafeArea(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: RoundButton(
                      title: "Get Started",
                      type: isChangeColor
                          ? RoundButtonType.textGradient
                          : RoundButtonType.bgGradient,
                      onPressed: () {
                        if (isChangeColor) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const FitnessGoalInputScreen()));
                        } else {
                          setState(() {
                            isChangeColor = true;
                          });
                        }
                      }),
                ))
              ],
            )));
  }
}

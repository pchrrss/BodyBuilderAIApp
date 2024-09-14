import 'package:bodybuilderaiapp/common/color_extension.dart';
import 'package:bodybuilderaiapp/common_widget/round_button.dart';
import 'package:bodybuilderaiapp/common_widget/round_textfield.dart';
import 'package:bodybuilderaiapp/view/user_input/fitness_goal_input_screen.dart';
import 'package:flutter/material.dart';

class CompleteProfileView extends StatefulWidget {
  const CompleteProfileView({super.key});

  @override
  State<CompleteProfileView> createState() => _CompleteProfileViewState();
}

class _CompleteProfileViewState extends State<CompleteProfileView> {
  TextEditingController txtDate = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: TColor.white,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      SizedBox(height: media.height * 0.05),
                      Text(
                        "Let's complete your profile",
                        style: TextStyle(
                            color: TColor.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "It will help us to know you better",
                        style: TextStyle(color: TColor.grey, fontSize: 12),
                      ),
                      SizedBox(height: media.height * 0.05),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: TColor.lightGrey,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: 50,
                                      height: 50,
                                      padding: const EdgeInsets.symmetric(horizontal: 15),
                                      child: Icon(Icons.person, color: TColor.grey),
                                    ),
                                    Expanded(
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                            items: ["Male", "Female"]
                                                .map((value) => DropdownMenuItem(
                                                      value: value,
                                                      child: Text(
                                                        value,
                                                        style: TextStyle(
                                                            color: TColor.grey,
                                                            fontSize: 16),
                                                      ),
                                                    ))
                                                .toList(),
                                            onChanged: (value) {},
                                            isExpanded: true,
                                            icon: const Icon(Icons.arrow_drop_down),
                                            hint: Text(
                                              "Choose Gender",
                                              style: TextStyle(
                                                  color: TColor.grey, fontSize: 16),
                                            )),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                  ],
                                )),
                            SizedBox(height: media.height * 0.03),
                            RoundTextfield(
                              controller: txtDate,
                              hintText: "Date of Birth",
                              icon: Icons.calendar_today,
                            ),
                            SizedBox(height: media.height * 0.03),
                            Row(children: [
                              Expanded(
                                child: RoundTextfield(
                                  controller: txtDate,
                                  hintText: "Your Weight",
                                  icon: Icons.monitor_weight,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                  width: 50,
                                  height: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: TColor.secondaryGradient),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Text(
                                    "KG",
                                    style: TextStyle(
                                        color: TColor.white, fontSize: 12),
                                  ))
                            ]),
                            SizedBox(height: media.height * 0.03),
                            Row(children: [
                              Expanded(
                                child: RoundTextfield(
                                  controller: txtDate,
                                  hintText: "Your Height",
                                  icon: Icons.height,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                  width: 50,
                                  height: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: TColor.secondaryGradient),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Text(
                                    "CM",
                                    style: TextStyle(
                                        color: TColor.white, fontSize: 12),
                                  ))
                            ]),
                            SizedBox(height: media.height * 0.2),
                            RoundButton(
                                title: "Next >",
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const FitnessGoalInputScreen()));
                                }),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

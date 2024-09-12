import 'package:bodybuilderaiapp/common/color_extension.dart';
import 'package:bodybuilderaiapp/common_widget/round_button.dart';
import 'package:bodybuilderaiapp/common_widget/round_textfield.dart';
import 'package:flutter/material.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {

  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text(
                  "Plop",
                  style: TextStyle(color: TColor.grey, fontSize: 16),
                ),
                Text(
                  "Create an Account",
                  style: TextStyle(color: TColor.grey, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: media.height * 0.05),
                const RoundTextfield(
                  hintText: "First Name", 
                  icon: Icons.person,
                ),
                SizedBox(height: media.height * 0.04),
                const RoundTextfield(
                  hintText: "Last Name",
                  icon: Icons.person,
                ),
                SizedBox(height: media.height * 0.04),
                const RoundTextfield(
                  hintText: "Email",
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: media.height * 0.04),
                const RoundTextfield(
                  hintText: "Password",
                  icon: Icons.lock,
                  //fixme
                  suffixIcon: Icons.visibility,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                ),
                SizedBox(height: media.height * 0.04),
                Row(

                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isCheck = !isCheck;
                        });
                      }, 
                      icon: Icon(
                        isCheck ? Icons.check_box : Icons.check_box_outline_blank,
                        color: TColor.grey,
                      )
                    ),
                    Expanded(child: Text(
                      "I agree to the Terms of Service and Privacy Policy",
                      style: TextStyle(color: TColor.grey, fontSize: 12),
                    ))
                  ],
                ),
                SizedBox(height: media.height * 0.2),
                RoundButton(title: "Register", onPressed: () {}, type: RoundButtonType.bgGradient),
              ],
            ),
          ),
        ),
      )
    );
  }
}
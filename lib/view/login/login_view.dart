import 'package:bodybuilderaiapp/common/color_extension.dart';
import 'package:bodybuilderaiapp/common_widget/round_button.dart';
import 'package:bodybuilderaiapp/common_widget/round_textfield.dart';
import 'package:bodybuilderaiapp/view/login/complete_profile_view.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Plop",
                    style: TextStyle(color: TColor.grey, fontSize: 16),
                  ),
                  Text(
                    "Login",
                    style: TextStyle(
                        color: TColor.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: media.height * 0.05),
                  const RoundTextfield(
                    hintText: "Email",
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: media.height * 0.03),
                  const RoundTextfield(
                    hintText: "Password",
                    icon: Icons.lock,
                    //fixme
                    suffixIcon: Icons.visibility,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  SizedBox(height: media.height * 0.03),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              isCheck = !isCheck;
                            });
                          },
                          icon: Icon(
                            isCheck
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            color: TColor.grey,
                          )),
                      Expanded(
                          child: Text(
                        "I agree to the Terms of Service and Privacy Policy",
                        style: TextStyle(color: TColor.grey, fontSize: 12),
                      ))
                    ],
                  ),
                  SizedBox(height: media.height * 0.2),
                  RoundButton(
                      title: "Register",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CompleteProfileView()));
                      }),
                ],
              ),
            ),
          ),
        ));
  }
}

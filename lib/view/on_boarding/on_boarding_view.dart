import 'package:bodybuilderaiapp/common/color_extension.dart';
import 'package:bodybuilderaiapp/common_widget/on_boarding_page.dart';
import 'package:bodybuilderaiapp/view/login/auth_guard.dart';
import 'package:flutter/material.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  int selectPage = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        selectPage = _pageController.page!.toInt();
      });
    });
  }

  List pageList = [
    // create a specific object for onboarding
    {
      "title": "Welcome to Body Builder AI",
      "description": "Get your body in shape with our AI",
      "img": "assets/img/onboarding1.webp",
    },
    {
      "title": "Welcome to Body Builder AI 2",
      "description": "Personalized workouts powered by artificial intelligence and machine learning.",
      "img": "assets/img/onboarding2.webp",
    },
    {
      "title": "Welcome to Body Builder AI 3",
      "description": "AI-driven fitness coach for customized exercise routines and tracking.",
      "img": "assets/img/onboarding3.png",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: pageList.length,
            itemBuilder: (context, index) {
              var pObj = pageList[index] as Map? ?? {};
              return OnBoardingPage(pObj: pObj);
            },
          ),
          SizedBox(
            width: 120,
            height: 120,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    return SizedBox(
                      width: 70,
                      height: 70,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(TColor.secondaryColor1),
                        value: ((_pageController.page ?? 0) + 1) / pageList.length,
                        strokeWidth: 2,
                      ),
                    );
                  },
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      color: TColor.primaryColor1,
                      borderRadius: BorderRadius.circular(35)),
                  child: IconButton(
                      icon: Icon(Icons.navigate_next, color: TColor.white),
                      color: TColor.secondaryColor1,
                      onPressed: () {
                        if (selectPage < pageList.length - 1) {
                          selectPage++;
                          _pageController.animateToPage(selectPage,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        } else {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthGuard()));  
                        }
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

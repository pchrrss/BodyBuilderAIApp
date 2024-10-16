import 'package:bodybuilderaiapp/common/color_extension.dart';
import 'package:bodybuilderaiapp/view/home/activity_screen.dart';
import 'package:bodybuilderaiapp/view/home/favorite_screen.dart';
import 'package:bodybuilderaiapp/view/home/fitness_plan_result_screen.dart';
import 'package:bodybuilderaiapp/model/user_input_model.dart';
import 'package:bodybuilderaiapp/view/home/home_screen.dart';

import 'package:flutter/material.dart';

class MainAppWithNavigation extends StatefulWidget {
  final String userId;
  final UserInputModel userInput;

  const MainAppWithNavigation({super.key, required this.userId, required this.userInput});

  @override
  State<MainAppWithNavigation> createState() => _MainAppWithNavigationState();
}

class _MainAppWithNavigationState extends State<MainAppWithNavigation> {
  int _currentIndex = 1;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeScreen(userId: widget.userId, userInput: widget.userInput),
      FitnessPlanResultScreen(userId: widget.userId, userInput: widget.userInput),
      ActivityScreen(userInput: widget.userInput),
      FavoriteScreen(userId: widget.userId, userInput: widget.userInput)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            top: BorderSide(
              color: TColor.lightGrey,
              width: 1,
            ),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: _currentIndex,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          iconSize: 20,
          selectedFontSize: 14,
          unselectedFontSize: 12,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center),
              label: 'Plan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard),
              label: 'Activity',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorite',
            )
          ],
        ),
      ),
    );
  }
}

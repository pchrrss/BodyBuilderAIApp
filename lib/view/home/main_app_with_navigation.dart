import 'package:bodybuilderaiapp/common/color_extension.dart';
import 'package:bodybuilderaiapp/common_widget/transparent_app_bar_with_border.dart';
import 'package:bodybuilderaiapp/view/home/favorite_screen.dart';
import 'package:bodybuilderaiapp/view/home/fitness_plan_result_screen.dart';
import 'package:bodybuilderaiapp/model/user_input_model.dart';

import 'package:flutter/material.dart';

class MainAppWithNavigation extends StatefulWidget {
  final String userId;
  final UserInputModel userInput;

  const MainAppWithNavigation({super.key, required this.userId, required this.userInput});

  @override
  State<MainAppWithNavigation> createState() => _MainAppWithNavigationState();
}

class _MainAppWithNavigationState extends State<MainAppWithNavigation> {
  int _currentIndex = 0;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeScreen(userInput: widget.userInput),
      FitnessPlanResultScreen(userId: widget.userId, userInput: widget.userInput),
      ActivityScreen(userInput: widget.userInput),
      FavoriteScreen(userId: widget.userId, userInput: widget.userInput)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // fixme - how manage app bar ? on differnte screen or in main app ?
      // appBar: AppBar(
      //   title: Text(_getAppBarTitle(_currentIndex),
      //       style: TextStyle(color: TColor.white, fontWeight: FontWeight.bold)),
      //   backgroundColor: TColor.primaryColor1,
      //   automaticallyImplyLeading: false,
      // ),
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

  String _getAppBarTitle(int index) {
    switch (index) {
      case 0:
        return "Home";
      case 1:
        return "Plan";
      case 2:
        return "Activity";
      case 3:
        return "Favorite";
      default:
        return "Plan";
    }
  }
}

class HomeScreen extends StatelessWidget {
  final UserInputModel userInput;
  const HomeScreen({super.key, required this.userInput});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBarWithBorder(title: 'Home', userInput: userInput),
      body: const Center(
        child: Text(
          'Home Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class ActivityScreen extends StatelessWidget {
  final UserInputModel userInput;
  const ActivityScreen({super.key, required this.userInput});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBarWithBorder(title: 'Activity', userInput: userInput),
      body: const Center(
        child: Text(
          'Activity Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

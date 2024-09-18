import 'package:bodybuilderaiapp/view/home/favorite_screen.dart';
import 'package:bodybuilderaiapp/view/home/fitness_plan_result_screen.dart';
import 'package:bodybuilderaiapp/view/home/profile_view.dart';
import 'package:bodybuilderaiapp/view/user_input/user_input_model.dart';

import 'package:flutter/material.dart';

class MainAppWithNavigation extends StatefulWidget {
  final String userId;
  final UserInputModel userInput;

  const MainAppWithNavigation(
      {super.key, required this.userId, required this.userInput});

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
      FitnessPlanResultScreen(
          userId: widget.userId, userInput: widget.userInput),
      CalendarScreen(),
      FavoriteScreen(userInput: widget.userInput),
      ProfileView(userInput: widget.userInput)
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
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: _currentIndex,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center),
              label: 'Plan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  String _getAppBarTitle(int index) {
    switch (index) {
      case 0:
        return "Plan";
      case 1:
        return "Calendar";
      case 2:
        return "Favorite";
      case 3:
        return "Profile";
      default:
        return "Plan";
    }
  }
}

class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Calendar Screen',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

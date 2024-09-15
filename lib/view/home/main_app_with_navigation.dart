import 'package:bodybuilderaiapp/common/color_extension.dart';
import 'package:bodybuilderaiapp/view/home/favorite_screen.dart';
import 'package:bodybuilderaiapp/view/home/fitness_plan_result_screen.dart';
import 'package:bodybuilderaiapp/view/user_input/user_input_model.dart';
import 'package:flutter/material.dart';

class MainAppWithNavigation extends StatefulWidget {
  final UserInputModel userInput;

  const MainAppWithNavigation({super.key, required this.userInput});

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
      FitnessPlanResultScreen(userInput: widget.userInput),
      CalendarScreen(),
      FavoriteScreen(userInput: widget.userInput),
      ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle(_currentIndex), style: TextStyle(color: TColor.white)),
        backgroundColor: TColor.primaryColor1,
        automaticallyImplyLeading: false,
      ),
      body: _pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: TColor.primaryColor1,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 25,
        unselectedItemColor: TColor.secondaryColor2,
        selectedItemColor: TColor.secondaryColor1,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: "Plan",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "Calendar",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
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

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Profile Screen',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

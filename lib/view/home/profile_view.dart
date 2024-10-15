import 'package:bodybuilderaiapp/common/color_extension.dart';
import 'package:bodybuilderaiapp/common_widget/transparent_app_bar_with_border.dart';
import 'package:bodybuilderaiapp/view/login/logout_view.dart';
import 'package:bodybuilderaiapp/view/user_input/fitness_goal_input_screen.dart';
import 'package:bodybuilderaiapp/model/user_input_model.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  final UserInputModel userInput;
  const ProfileView({super.key, required this.userInput});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBarWithBorder(
        title: 'Profile',
        userInput: userInput,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LogoutView(),
                ),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Profile Information:',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: TColor.black,
              ),
            ),
            const SizedBox(height: 20),
            _buildProfileItem(
                'Age Range', userInput.ageRange ?? 'Not specified'),
            _buildProfileItem(
                'Body Type', userInput.bodyType ?? 'Not specified'),
            _buildProfileItem(
                'Fitness Goal', userInput.fitnessGoal ?? 'Not specified'),
            _buildProfileItem(
                'Body Fat Range', userInput.bodyFatRange ?? 'Not specified'),
            _buildProfileItem('Focus Areas',
                userInput.focusAreas?.join(', ') ?? 'Not specified'),
            _buildProfileItem('Fitness Level',
                userInput.fitnessLevel?.toString() ?? 'Not specified'),
            _buildProfileItem(
                'Available Equipment', userInput.equipment ?? 'Not specified'),
            _buildProfileItem('Workout Days',
                userInput.workoutDays?.toString() ?? 'Not specified'),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FitnessGoalInputScreen(),
                    ),
                  );
                },
                child: const Text('Update Information'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

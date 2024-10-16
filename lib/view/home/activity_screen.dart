import 'package:bodybuilderaiapp/common_widget/transparent_app_bar_with_border.dart';
import 'package:bodybuilderaiapp/model/user_input_model.dart';
import 'package:bodybuilderaiapp/model/fitness_plan_result.dart';
import 'package:bodybuilderaiapp/service/firebase_firestore_http_service.dart';
import 'package:bodybuilderaiapp/view/home/history_screen.dart';
import 'package:flutter/material.dart';

class ActivityScreen extends StatefulWidget {
    final String userId;
  final UserInputModel userInput;
  const ActivityScreen({super.key, required this.userId, required this.userInput});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final FirebaseFirestoreHttpService _firestoreService = FirebaseFirestoreHttpService();
  Future<List<FitnessPlanResult>>? fitnessPlansFuture;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fitnessPlansFuture = _firestoreService.fetchAllFitnessPlans(widget.userId);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBarWithBorder(title: 'Activity', userInput: widget.userInput),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Theme.of(context).primaryColor,
            tabs: const [
              Tab(text: "History"),
              Tab(text: "Achievements"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildHistoryTab(),
                _buildAchievementsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return FutureBuilder<List<FitnessPlanResult>>(
      future: fitnessPlansFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading history: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          List<FitnessPlanResult> fitnessPlans = snapshot.data!;
          return HistoryScreen(fitnessPlans: fitnessPlans);
        } else {
          return const Center(child: Text('No history available.'));
        }
      },
    );
  }

  Widget _buildAchievementsTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.emoji_events, size: 50),
          SizedBox(height: 10),
          Text('Your Achievements'),
        ],
      ),
    );
  }
}

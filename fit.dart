import 'package:flutter/material.dart';
import 'water-screen.dart';

class FitScreen extends StatefulWidget {
  @override
  _FitScreenState createState() => _FitScreenState();
}

class _FitScreenState extends State<FitScreen> {
  String selectedGoal = 'Weight Loss';

  final Map<String, List<String>> exercises = {
    'Weight Loss': ['Running for 30 minutes', 'HIIT workout for 20 minutes', 'Jump rope'],
    'Muscle Gain': ['Weightlifting exercises', 'Push-ups', 'Squats'],
    'Maintain Weight': ['Walking for 40 minutes', 'Flexibility exercises', 'Pilates']
  };

  final Map<String, List<String>> dietPlan = {
    'Weight Loss': ['Grilled chicken breast', 'Fiber-rich salad', 'Plenty of water'],
    'Muscle Gain': ['Chicken breast + Brown rice', 'Potato + Fish', 'Protein shake'],
    'Maintain Weight': ['Balanced meals', 'Fruits and vegetables', 'Drinking water']
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Workout & Nutrition Plan')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Choose your goal:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: selectedGoal,
              onChanged: (value) => setState(() => selectedGoal = value!),
              items: ['Weight Loss', 'Muscle Gain', 'Maintain Weight'].map(
                    (goal) => DropdownMenuItem(value: goal, child: Text(goal)),
              ).toList(),
            ),
            SizedBox(height: 20),
            Text('💪 Workouts:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...exercises[selectedGoal]!.map((exercise) => Text('- $exercise')),
            SizedBox(height: 20),
            Text('🍏 Nutrition Plan:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...dietPlan[selectedGoal]!.map((food) => Text('- $food')),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Back'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WaterScreen()),
                );
              },
              child: Text('Calculate Your Water Intake'),
            ),
          ],
        ),
      ),
    );
  }
}

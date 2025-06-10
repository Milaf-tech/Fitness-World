import 'package:flutter/material.dart';

class WaterScreen extends StatefulWidget {
  @override
  _WaterScreenState createState() => _WaterScreenState();
}

class _WaterScreenState extends State<WaterScreen> {
  final weightController = TextEditingController();
  final exerciseController = TextEditingController();
  double? waterNeed;

  void calculateWater() {
    double weight = double.tryParse(weightController.text) ?? 0;
    double exerciseHours = double.tryParse(exerciseController.text) ?? 0;

    waterNeed = (weight * 0.033) + (exerciseHours * 0.5);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '💧 Daily Water Intake Calculator',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Enter your weight (kg):', style: TextStyle(fontSize: 18)),
            TextField(controller: weightController, keyboardType: TextInputType.number),
            SizedBox(height: 10),
            Text('Hours of exercise per day:', style: TextStyle(fontSize: 18)),
            TextField(controller: exerciseController, keyboardType: TextInputType.number),
            SizedBox(height: 20),
            ElevatedButton(onPressed: calculateWater, child: Text('Calculate Water Intake')),
            SizedBox(height: 20),
            if (waterNeed != null)
              Text('🌊 You need ${waterNeed!.toStringAsFixed(2)} liters of water daily!', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}

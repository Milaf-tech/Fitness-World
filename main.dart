import 'package:flutter/material.dart';
import 'fit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DataEntryScreen(),
    );
  }
}

class DataEntryScreen extends StatefulWidget {
  @override
  _DataEntryScreenState createState() => _DataEntryScreenState();
}

class _DataEntryScreenState extends State<DataEntryScreen> {
  final ageController = TextEditingController();
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  String? selectedGender;
  double? tdee;
  String? bmiCategory;

  void calculateData() {
    double? weight = double.tryParse(weightController.text);
    double? height = double.tryParse(heightController.text);
    int? age = int.tryParse(ageController.text);
    String gender = selectedGender ?? 'Not Specified';

    if (weight == null || height == null || age == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('⚠ Please enter valid data')),
      );
      return;
    }

    double bmr = (gender == 'Male')
        ? 88.36 + (13.4 * weight) + (4.8 * height * 100) - (5.7 * age)
        : 447.6 + (9.2 * weight) + (3.1 * height * 100) - (4.3 * age);

    double bmi = weight / (height * height);
    tdee = bmr * 1.55;
    bmiCategory = getBMICategory(bmi);

    setState(() {});

    if (bmiCategory == 'Obese') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('⚠ You are obese, redirecting to workout plans')),
      );
    }
    if (bmiCategory == 'Healthy Weight') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('✔ Your weight is ideal, keep maintaining it!')),
      );
    }
    if (bmiCategory == 'Underweight') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('⚠ Your weight is below normal')),
      );
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FitScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Enter Data')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildTextField(ageController, 'Age'),
            buildTextField(weightController, 'Weight (kg)'),
            buildTextField(heightController, 'Height (m)'),
            DropdownButton<String>(
              value: selectedGender,
              hint: Text('Gender'),
              onChanged: (value) => setState(() => selectedGender = value),
              items: ['Male', 'Female']
                  .map((val) => DropdownMenuItem(value: val, child: Text(val)))
                  .toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: calculateData, child: Text('Calculate & Proceed')),
            SizedBox(height: 20),
            if (tdee != null && bmiCategory != null)
              Text('Daily Calories: ${tdee!.toStringAsFixed(2)} kcal\nWeight Category: $bmiCategory'),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
    );
  }

  String getBMICategory(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 24.9) return 'Healthy Weight';
    if (bmi < 29.9) return 'Overweight';
    return 'Obese';
  }
}

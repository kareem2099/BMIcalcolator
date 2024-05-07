import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:bmicalc/widget/gender.dart';

class CalculatedBMIScreen extends StatelessWidget {
  final double height;
  final double weight;
  final int age;
  final Gender gender;
  final double bmr;
  final double dailyCalories;

  const CalculatedBMIScreen({
    Key? key, // The Key parameter is optional and can be null
    required this.height,
    required this.weight,
    required this.age,
    required this.gender,
    required this.bmr,
    required this.dailyCalories,
  }) : super(key: key);

  Color _getBarColor(double bmi) {
    if (bmi < 18.5) {
      return Colors.yellow;
    } else if (bmi < 25) {
      return Colors.green;
    } else if (bmi < 30) {
      return Colors.orange;
    } else if (bmi < 35) {
      return Colors.red;
    } else {
      return Colors.black;
    }
  }

  Color _getGenderColor() {
    return gender == Gender.male ? Colors.pink : Colors.blue;
  }

  double calculateBMI(double height, double weight) {
    return weight / ((height / 100) * (height / 100));
  }

  double adjustBMIForGender(double bmi) {
    if (gender == Gender.male) {
      return bmi * 1.1;
    } else {
      return bmi * 0.9;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Calculate BMI
    double bmi = calculateBMI(height, weight);
    double adjustedBMI = adjustBMIForGender(bmi);

    // Determine the BMI category
    String bmiCategory;
    if (bmi < 18.5) {
      bmiCategory = 'Underweight';
    } else if (bmi < 25) {
      bmiCategory = 'Normal';
    } else if (bmi < 30) {
      bmiCategory = 'Overweight';
    } else if (bmi < 35) {
      bmiCategory = 'Obese';
    } else {
      bmiCategory = 'Extremely Obese';
    }

    Color genderColor = _getGenderColor();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculated BMI'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SfLinearGauge(
              minimum: 10,
              maximum: 40,
              interval: 5,
              animateAxis: true,
              animationDuration: 3000,
              isAxisInversed: false,
              axisTrackStyle: const LinearAxisTrackStyle(thickness: 15),
              markerPointers: [
                LinearWidgetPointer(
                  value: bmi,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: _getBarColor(bmi),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
              barPointers: [
                LinearBarPointer(
                  value: bmi,
                  enableAnimation: true,
                  animationDuration: 3000,
                  thickness: 15,
                  color: _getBarColor(bmi), // Dynamic color based on BMI
                ),
              ],
              ranges: const [
                LinearGaugeRange(
                  startValue: 10,
                  endValue: 18.5,
                  startWidth: 15,
                  endWidth: 15,
                  color: Colors.yellow,
                ),
                LinearGaugeRange(
                  startValue: 18.5,
                  endValue: 25,
                  startWidth: 15,
                  endWidth: 15,
                  color: Colors.green,
                ),
                LinearGaugeRange(
                  startValue: 25,
                  endValue: 30,
                  startWidth: 15,
                  endWidth: 15,
                  color: Colors.orange,
                ),
                LinearGaugeRange(
                  startValue: 30,
                  endValue: 35,
                  startWidth: 15,
                  endWidth: 15,
                  color: Colors.red,
                ),
                LinearGaugeRange(
                  startValue: 35,
                  endValue: 40,
                  startWidth: 15,
                  endWidth: 15,
                  color: Colors.black,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Adjusted BMI: ${adjustedBMI.toStringAsFixed(1)}',
              style: TextStyle(fontSize: 24, color: genderColor),
            ),
            const SizedBox(height: 20),
            Text(
              'Category: $bmiCategory',
              style: TextStyle(fontSize: 20, color: genderColor),
            ),
            Text('Your BMR: ${bmr.toStringAsFixed(2)}'),
            Text(
                'Your Daily Calorie Needs: ${dailyCalories.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}

import 'package:bmicalc/screen/bmi_calc_screen.dart';
// import 'package:bmicalc/screen/main_menu_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Add a Key parameter

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BMIcalcScreen(), // Set BMIcalcScreen as the home screen
    );
  }
}

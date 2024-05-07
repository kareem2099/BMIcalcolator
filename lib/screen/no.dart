
// import 'package:flutter/material.dart';
// import 'package:bmicalc/widget/gender.dart';
// import 'package:bmicalc/widget/calc_calorie.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:flip_card/flip_card.dart';
// import 'package:flutter/services.dart';
// import 'package:syncfusion_flutter_gauges/gauges.dart';


// class CalorieCalcScreen extends StatefulWidget {
//   const CalorieCalcScreen({Key? key}) : super(key: key);

//   @override
//   _CalorieCalcScreenState createState() => _CalorieCalcScreenState();
// }

// class _CalorieCalcScreenState extends State<CalorieCalcScreen> {
//   GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
//   Gender selectedGender = Gender.male; // Default gender
//   double weight = 60; // Default weight
//   double height = 170; // Default height
//   int age = 25; // Default age
//   ActivityLevel selectedActivityLevel =
//       ActivityLevel.sedentary; // Default activity level
//  // Add a TextEditingController for the weight input
//   TextEditingController weightController = TextEditingController();
//   double bmr = 0;
//   double dailyCalories = 0;

//   void calculate() {
//     setState(() {
//       bmr = calculateBMR(weight, height, age, selectedGender);
//       dailyCalories = calculateDailyCalories(bmr, selectedActivityLevel);
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     // Set the initial value for the weight controller
//     weightController.text = weight.toStringAsFixed(1);
//   }

//   @override
//   void dispose() {
//     // Dispose the controller when the widget is removed from the widget tree
//     weightController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//   Color genderColor =
//         selectedGender == Gender.male ? Colors.pink : Colors.blue;
        
//     return Scaffold(
//       appBar: AppBar(
//         title: AnimatedDefaultTextStyle(
//           duration: const Duration(milliseconds: 300),
//           style: TextStyle(
//             fontSize: 24,
//             // color: genderColor, // Animate the color based on gender
//           ),
//           child: AnimatedTextKit(
//             animatedTexts: [
//               TypewriterAnimatedText(
//                 'BMI Calculator', // Your desired title
//                 textStyle: const TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 speed: const Duration(
//                     milliseconds: 200), // Adjust the typing speed
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               // Input fields for weight, height, and age
//               TextFormField(
//                 initialValue: weight.toString(),
//                 decoration: const InputDecoration(
//                   labelText: 'Weight (kg)',
//                 ),
//                 keyboardType: TextInputType.number,
//                 onChanged: (val) => setState(() => weight = double.parse(val)),
//               ),
//               TextFormField(
//                 initialValue: height.toString(),
//                 decoration: const InputDecoration(
//                   labelText: 'Height (cm)',
//                 ),
//                 keyboardType: TextInputType.number,
//                 onChanged: (val) => setState(() => height = double.parse(val)),
//               ),
//               TextFormField(
//                 initialValue: age.toString(),
//                 decoration: const InputDecoration(
//                   labelText: 'Age',
//                 ),
//                 keyboardType: TextInputType.number,
//                 onChanged: (val) => setState(() => age = int.parse(val)),
//               ),
//               // Gender selection
//               ListTile(
//                 title: const Text('Male'),
//                 leading: Radio<Gender>(
//                   value: Gender.male,
//                   groupValue: selectedGender,
//                   onChanged: (Gender? value) {
//                     setState(() {
//                       selectedGender = value!;
//                     });
//                   },
//                 ),
//               ),
//               ListTile(
//                 title: const Text('Female'),
//                 leading: Radio<Gender>(
//                   value: Gender.female,
//                   groupValue: selectedGender,
//                   onChanged: (Gender? value) {
//                     setState(() {
//                       selectedGender = value!;
//                     });
//                   },
//                 ),
//               ),
//               // Activity level selection
//               DropdownButton<ActivityLevel>(
//                 value: selectedActivityLevel,
//                 onChanged: (ActivityLevel? newValue) {
//                   setState(() {
//                     selectedActivityLevel = newValue!;
//                   });
//                 },
//                 items: ActivityLevel.values.map((ActivityLevel classType) {
//                   return DropdownMenuItem<ActivityLevel>(
//                     value: classType,
//                     child: Text(classType.toString().split('.').last),
//                   );
//                 }).toList(),
//               ),
//               // Calculate button
//               ElevatedButton(
//                 onPressed: calculate,
//                 child: const Text('Calculate Daily Calorie Needs'),
//               ),
//               // Display the results
//               Text('Your BMR: ${bmr.toStringAsFixed(2)}'),
//               Text(
//                   'Your Daily Calorie Needs: ${dailyCalories.toStringAsFixed(2)}'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

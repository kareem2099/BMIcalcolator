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
//   State<CalorieCalcScreen> createState() => _CalorieCalcScreenState();
// }

// class _CalorieCalcScreenState extends State<CalorieCalcScreen> {
//   GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
//   Gender selectedGender = Gender.female; // Default gender
//   double height = 155; // Default height
//   int age = 25; // Default age
//   double weight = 0; // Default weight
//   ActivityLevel selectedActivityLevel =
//       ActivityLevel.sedentary; // Default activity level
//   // Add a TextEditingController for the weight input
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
//     Color genderColor =
//         selectedGender == Gender.male ? Colors.pink : Colors.blue;

//     return Scaffold(
//       appBar: AppBar(
//         title: AnimatedDefaultTextStyle(
//           duration: const Duration(milliseconds: 300),
//           style: TextStyle(
//             fontSize: 24,
//             color: genderColor, // Animate the color based on gender
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
//       body: Column(
//         children: <Widget>[
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               FlipCard(
//                 key: cardKey,
//                 flipOnTouch: true, // Set to true to allow flip on touch
//                 front: GestureDetector(
//                   onTap: () {
//                     cardKey.currentState?.toggleCard();
//                     setState(() {
//                       selectedGender = Gender.male;
//                     });
//                   },
//                   child: const GenderCard(
//                     gender: Gender.male,
//                     icon: Icons.male,
//                     color: Colors.blue,
//                   ),
//                 ),
//                 back: GestureDetector(
//                   onTap: () {
//                     cardKey.currentState?.toggleCard();
//                     setState(() {
//                       selectedGender = Gender.female;
//                     });
//                   },
//                   child: const GenderCard(
//                     gender: Gender.female,
//                     icon: Icons.female,
//                     color: Colors.pink,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           // Custom height slider
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               children: [
//                 Text(
//                   'Height',
//                   style: TextStyle(
//                     fontSize: 20,
//                     color: genderColor,
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       '155 cm',
//                       style: TextStyle(
//                         fontSize: 20,
//                         color: genderColor,
//                       ),
//                     ),
//                     Text(
//                       '200 cm',
//                       style: TextStyle(
//                         fontSize: 20,
//                         color: genderColor,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SfLinearGauge(
//                   minimum: 150,
//                   maximum: 200,
//                   interval: 10,
//                   animateAxis: true,
//                   animationDuration: 3000,
//                   isAxisInversed: true,
//                   markerPointers: [
//                     LinearShapePointer(
//                       value: height,
//                       onChanged: (newValue) {
//                         setState(() {
//                           height = newValue;
//                         });
//                       },
//                     ),
//                   ],
//                   barPointers: [
//                     LinearBarPointer(
//                       value: height,
//                       enableAnimation: true,
//                       animationDuration: 3000,
//                       color: genderColor,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   'your height ${height.round()} cm',
//                   style: TextStyle(
//                     fontSize: 20,
//                     color: genderColor,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // Age and weight selection
//           const SizedBox(height: 30),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               // Age selection
//               Column(
//                 children: <Widget>[
//                   Text('Age',
//                       style: TextStyle(fontSize: 20, color: genderColor)),
//                   Text('$age',
//                       style: TextStyle(fontSize: 20, color: genderColor)),
//                   Row(
//                     children: <Widget>[
//                       FloatingActionButton(
//                         onPressed: () {
//                           setState(() {
//                             age--;
//                           });
//                         },
//                         mini: true,
//                         child: const Icon(Icons.remove),
//                       ),
//                       FloatingActionButton(
//                         onPressed: () {
//                           setState(() {
//                             age++;
//                           });
//                         },
//                         mini: true,
//                         child: const Icon(Icons.add),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               // Weight selection
//               Column(
//                 children: <Widget>[
//                   Text('Weight',
//                       style: TextStyle(fontSize: 20, color: genderColor)),
//                   SizedBox(
//                     width: 170, // Provide a finite width constraint
//                     child: TextField(
//                       controller: weightController,
//                       keyboardType:
//                           const TextInputType.numberWithOptions(decimal: true),
//                       inputFormatters: [
//                         FilteringTextInputFormatter.allow(
//                             RegExp(r'(^\d*\.?\d{0,1}$)')),
//                       ],
//                       onChanged: (value) {
//                         setState(() {
//                           weight = double.tryParse(value) ?? weight;
//                         });
//                       },
//                       decoration: const InputDecoration(
//                         hintText: 'Enter your weight',
//                         suffixText: 'kg',
//                       ),
//                     ),
//                   ),
//                   Text(
//                     'Your weight is ${weight.toStringAsFixed(1)} kg',
//                     style: TextStyle(
//                       fontSize: 20,
//                       color: genderColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           const SizedBox(height: 50),
//           // Calculate button
//           ElevatedButton(
//             onPressed: calculate,
//             child: const Text('Calculate Daily Calorie Needs'),
//           ),
//           // Display the results
//           Text('Your BMR: ${bmr.toStringAsFixed(2)}'),
//           Text('Your Daily Calorie Needs: ${dailyCalories.toStringAsFixed(2)}'),
//         ],
//       ),
//     );
//   }
// }

// class GenderCard extends StatelessWidget {
//   final Gender gender;
//   final IconData icon;
//   final Color color;

//   const GenderCard({
//     Key? key,
//     required this.gender,
//     required this.icon,
//     required this.color,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: color,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: <Widget>[
//             Icon(icon, size: 100, color: Colors.white),
//             Text(
//               gender == Gender.male ? 'Male' : 'Female',
//               style: const TextStyle(color: Colors.white),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'bmi_calc_screen.dart';
// import 'calorie_calc_screen.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';

// class MainMenuScreen extends StatelessWidget {
//   const MainMenuScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
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
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const BMIcalcScreen()),
//                 );
//               },
//               child: const Text('BMI Calculator'),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const BMIcalcScreen()),
//                 );
//               },
//               child: const Text('Calorie Calculator'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

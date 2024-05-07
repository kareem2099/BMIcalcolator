import 'package:flutter/material.dart';
import 'gender.dart';

class GenderSelectionWidget extends StatefulWidget {
  const GenderSelectionWidget({Key? key})
      : super(key: key); // Add a Key parameter

  @override
  State<GenderSelectionWidget> createState() => _GenderSelectionWidgetState();
}

class _GenderSelectionWidgetState extends State<GenderSelectionWidget> {
  Gender selectedGender = Gender.male; // Default to male

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Male button
        GestureDetector(
          onTap: () {
            setState(() {
              selectedGender = Gender.male;
            });
          },
          child: Container(
            color: selectedGender == Gender.male ? Colors.blue : Colors.grey,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Icon(Icons.male, size: 100, color: Colors.white),
                  Text('Male', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 20), // Spacing between buttons
        // Female button
        GestureDetector(
          onTap: () {
            setState(() {
              selectedGender = Gender.female;
            });
          },
          child: Container(
            color: selectedGender == Gender.female ? Colors.pink : Colors.grey,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Icon(Icons.female, size: 100, color: Colors.white),
                  Text('Female', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:bmicalc/widget/calcbmi_widget.dart';
import 'package:bmicalc/widget/calc_calorie.dart';
// import 'package:bmicalc/widget/shake_animation_widgeth.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bmicalc/widget/gender.dart';
// import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
// import 'package:fancy_containers/fancy_containers.dart';

class BMIcalcScreen extends StatefulWidget {
  const BMIcalcScreen({Key? key}) : super(key: key); // Add a Key parameter

  @override
  State<BMIcalcScreen> createState() => _BMIcalcScreenState();
}

class _BMIcalcScreenState extends State<BMIcalcScreen> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  Gender selectedGender = Gender.female; // Default to male
  double height = 155; // Default height
  int age = 25; // Default age
  double weight = 0; // Default weight
  double bmr = 0;
  double dailyCalories = 0;

  ActivityLevel selectedActivityLevel =
      ActivityLevel.sedentary; // Default activity level
  // Add a TextEditingController for the weight input
  TextEditingController weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set the initial value for the weight controller
    weightController.text = weight.toStringAsFixed(1);
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is removed from the widget tree
    weightController.dispose();
    super.dispose();
  }

  void _calculateBMIAndCalories() {
    // Call the method to calculate BMR and daily calories
    calculateBMRAndCalories();

    // Navigate to the CalculatedBMIScreen with the calculated values
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CalculatedBMIScreen(
          height: height,
          weight: weight,
          age: age,
          gender: selectedGender,
          bmr: bmr, // Pass the calculated BMR
          dailyCalories: dailyCalories, // And the calculated daily calories
        ),
      ),
    );
  }

  void calculate() {
    setState(() {
      bmr = calculateBMR(weight, height, age, selectedGender);
      dailyCalories = calculateDailyCalories(bmr, selectedActivityLevel);
    });
  }

  void calculateBoth() {
    _calculateBMIAndCalories();
    calculate();
  }

  void calculateBMRAndCalories() {
    // Perform the calculations here
    double bmr = calculateBMR(weight, height, age, selectedGender);
    double dailyCalories = calculateDailyCalories(bmr, selectedActivityLevel);

    // Update the state with the new values
    setState(() {
      this.bmr = bmr;
      this.dailyCalories = dailyCalories;
      calculate();
    });
  }

  @override
  Widget build(BuildContext context) {
    Color genderColor =
        selectedGender == Gender.male ? Colors.pink : Colors.blue;

    // Color containerColor = selectedGender == Gender.male
    //     ? Color(0xff21f3e2)
    //     : Colors.deepPurpleAccent;

    return Scaffold(
      appBar: AppBar(
        title: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          style: TextStyle(
            fontSize: 24,
            color: genderColor, // Animate the color based on gender
          ),
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                'BMI Calculator', // Your desired title
                textStyle: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                speed: const Duration(
                    milliseconds: 200), // Adjust the typing speed
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlipCard(
                key: cardKey,
                flipOnTouch: true, // Set to true to allow flip on touch
                front: GestureDetector(
                  onTap: () {
                    cardKey.currentState?.toggleCard();
                    setState(() {
                      selectedGender = Gender.male;
                    });
                  },
                  child: const GenderCard(
                    gender: Gender.male,
                    icon: Icons.male,
                    color: Colors.blue,
                  ),
                ),
                back: GestureDetector(
                  onTap: () {
                    cardKey.currentState?.toggleCard();
                    setState(() {
                      selectedGender = Gender.female;
                    });
                  },
                  child: const GenderCard(
                    gender: Gender.female,
                    icon: Icons.female,
                    color: Colors.pink,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Custom height slider
          // Container(
          //   // color: containerColor,
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child:
          Column(
            children: [
              Text(
                'Height',
                style: TextStyle(
                  fontSize: 20,
                  color: genderColor,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '155 cm',
                    style: TextStyle(
                      fontSize: 20,
                      color: genderColor,
                    ),
                  ),
                  Text(
                    '200 cm',
                    style: TextStyle(
                      fontSize: 20,
                      color: genderColor,
                    ),
                  ),
                ],
              ),
              SfLinearGauge(
                minimum: 150,
                maximum: 200,
                interval: 10,
                animateAxis: true,
                animationDuration: 3000,
                isAxisInversed: true,
                markerPointers: [
                  LinearShapePointer(
                    value: height,
                    onChanged: (newValue) {
                      setState(() {
                        height = newValue;
                      });
                    },
                  ),
                ],
                barPointers: [
                  LinearBarPointer(
                    value: height,
                    enableAnimation: true,
                    animationDuration: 3000,
                    color: genderColor,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'your height ${height.round()} cm',
                style: TextStyle(
                  fontSize: 20,
                  color: genderColor,
                ),
              ),
            ],
          ),
          // ),
          // Create GlobalKey for each ShakeAnimationWidget

          // Age and weight selection
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // Age selection
              // Container(
              //   width: 150,
              //   height: 110,
              //   // color: containerColor,
              //   child:
              Column(
                children: <Widget>[
                  Text('Age',
                      style: TextStyle(fontSize: 20, color: genderColor)),
                  Text('$age',
                      style: TextStyle(fontSize: 20, color: genderColor)),
                  Row(
                    children: <Widget>[
                      const SizedBox(
                        width: 20,
                      ),
                      FloatingActionButton(
                        hoverColor: genderColor,
                        onPressed: () {
                          setState(() {
                            age--;
                          });
                        },
                        mini: true,
                        child: const Icon(Icons.remove),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      FloatingActionButton(
                        hoverColor: genderColor,
                        onPressed: () {
                          setState(() {
                            age++;
                          });
                        },
                        mini: true,
                        child: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
              // ),

              // Weight selection
              // Container(
              //   // color: containerColor,
              //   child:
              Column(
                children: <Widget>[
                  Text('Weight',
                      style: TextStyle(fontSize: 20, color: genderColor)),
                  SizedBox(
                    width: 150, // Provide a finite width constraint
                    child: TextField(
                      controller: weightController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'(^\d*\.?\d{0,1}$)')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          weight = double.tryParse(value) ?? weight;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'Enter your weight',
                        suffixText: 'kg',
                      ),
                    ),
                  ),
                  Text(
                    'Your weight is ${weight.toStringAsFixed(1)} kg',
                    style: TextStyle(
                      fontSize: 20,
                      color: genderColor,
                    ),
                  ),
                ],
              ),
              // ),
            ],
          ),
          const SizedBox(height: 50),

          ElevatedButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SimpleDialog(
                    title: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      style: TextStyle(
                        fontSize: 24,
                        color: genderColor, // Animate the color based on gender
                      ),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            'Select Activity Level', // Your desired title
                            textStyle: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            speed: const Duration(
                                milliseconds: 200), // Adjust the typing speed
                          ),
                        ],
                      ),
                    ),
                    children: ActivityLevel.values.map((ActivityLevel value) {
                      return SimpleDialogOption(
                        onPressed: () {
                          Navigator.pop(context, value);
                        },
                        child: Text(
                          value.toString().split('.').last,
                          style: TextStyle(color: genderColor),
                        ),
                      );
                    }).toList(),
                  );
                },
              ).then((value) {
                if (value != null) {
                  setState(() {
                    selectedActivityLevel = value;
                  });
                  calculateBoth();
                }
              });
            },
            child: Text(
              'show result',
              style: TextStyle(
                fontSize: 20,
                color: genderColor,
              ),
            ),
          ),

          // Display the BMI result here
        ],
      ),
    );
  }
}

class GenderCard extends StatelessWidget {
  final Gender gender;
  final IconData icon;
  final Color color;

  const GenderCard({
    Key? key,
    required this.gender,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Icon(icon, size: 100, color: Colors.white),
            Text(
              gender == Gender.male ? 'Male' : 'Female',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

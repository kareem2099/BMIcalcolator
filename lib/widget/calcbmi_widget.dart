import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:bmicalc/widget/gender.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pdf_widgets;
import 'dart:ui' as ui;
import 'package:permission_handler/permission_handler.dart';

import 'package:gallery_saver/gallery_saver.dart';
// import 'package:audioplayers/audioPlayers.dart';

class CalculatedBMIScreen extends StatelessWidget {
  final double height;
  final double weight;
  final int age;
  final Gender gender;
  final double bmr;
  final double dailyCalories;

  CalculatedBMIScreen({
    Key? key, // The Key parameter is optional and can be null
    required this.height,
    required this.weight,
    required this.age,
    required this.gender,
    required this.bmr,
    required this.dailyCalories,
  }) : super(key: key);

  final GlobalKey _globalKey = GlobalKey();

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

  void _showPNGSavedMessage(BuildContext context, String imagePath) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'PNG has been saved successfully at the following location: $imagePath'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showSavePNGErrorMessage(BuildContext context, dynamic e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('An error occurred while saving the image: $e'),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showPDFSavedMessage(BuildContext context, String pdfPath) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'PDF has been saved successfully at the following location: $pdfPath'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showSavePDFErrorMessage(BuildContext context, dynamic e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('An error occurred while saving the PDF file: $e'),
        backgroundColor: Colors.red,
      ),
    );
  }

  Future<Map<String, dynamic>> _capturePng(BuildContext context) async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Get the path to the device's storage directory
      final directory = (await getApplicationDocumentsDirectory()).path;
      // Combine the directory path and the image name to get the full image path
      File imgFile = File('$directory/screenshot.png');
      // Write the image to a file
      await imgFile.writeAsBytes(pngBytes);

      // Create a PDF document.
      final pdf = pdf_widgets.Document();

      // Add the image to the PDF document.
      pdf.addPage(
        pdf_widgets.Page(
          build: (pdf_widgets.Context context) => pdf_widgets.Center(
            child: pdf_widgets.Image(pdf_widgets.MemoryImage(pngBytes)),
          ),
        ),
      );

      // Save the PDF document to a file.
      final pdfFile = File('$directory/screenshot.pdf');
      await pdfFile.writeAsBytes(await pdf.save());
      _showPDFSavedMessage(context, '$directory/screenshot.pdf');
      return {'success': true, 'directory': directory};
    } catch (e) {
      _showSavePDFErrorMessage(context, e);
      return {'success': false};
    }
  }

  Future<void> _saveImage(BuildContext context, String imagePath) async {
    try {
      await GallerySaver.saveImage(imagePath, albumName: 'cutie');
      _showPNGSavedMessage(context, imagePath);
    } catch (e) {
      _showSavePNGErrorMessage(context, e);
    }
  }

  Future<void> _savepdf(BuildContext context, String pdfPath) async {
    try {
      await GallerySaver.saveImage(pdfPath, albumName: 'cutie');
      _showPDFSavedMessage(context, pdfPath); // Corrected method name
    } catch (e) {
      _showSavePDFErrorMessage(context, e); // Corrected method name
    }
  }

  Future<void> _requestPermissions() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
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
            ElevatedButton(
              onPressed: () async {
                try {
                  await _requestPermissions();
                  Map<String, dynamic> result = await _capturePng(context);
                  bool pngSaved =
                      result['success'] ?? false; // Added null check
                  String directory =
                      result['directory'] ?? ''; // Added null check
                  if (pngSaved && directory.isNotEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Choose File Format'),
                          content: const Text(
                              'Please choose a file format to save the file.'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('PNG'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                _saveImage(
                                    context, '$directory/screenshot.png');
                              },
                            ),
                            TextButton(
                              child: const Text('PDF'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                _savepdf(context, '$directory/screenshot.pdf');
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                } catch (e) {
                  _showSavePDFErrorMessage(context, e.toString());
                }
              },
              child: const Text('Save file'),
            ),
          ],
        ),
      ),
    );
  }
}

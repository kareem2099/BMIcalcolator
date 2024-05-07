// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/widgets.dart' as pdf_widgets;
// import 'dart:ui' as ui;
// import 'package:permission_handler/permission_handler.dart';
// import 'package:gallery_saver/gallery_saver.dart';

// class SaveFile extends StatefulWidget {
//   @override
//    _SaveFileState createState() =>  _SaveFileState();
// }

// class _SaveFileState extends State<SaveFile> {
//   late Future<void> _initializeFileSaveControllerFuture;

// @override
//   void initState() {
//     super.initState();
//     // _audioPlayer = AudioPlayer();
//     _initializeFileSaveControllerFuture = _initializeFileSave();
//     _requestPngPermission();
//     _requestPdfPermission();
//   }

//   Future<void> _requestPngPermission() async {
//     final permissionStatus = await Permission.storage.request();
//     if (permissionStatus == PermissionStatus.granted) {
//       _showPngPermissionDeniedMessage();
//     }
//   }

//   Future<void> _requestPdfPermission() async {
//     final permissionStatus = await Permission.storage.request();
//     if (permissionStatus == PermissionStatus.granted) {
//       _showPdfPermissionDeniedMessage();
//     }
//   }

//   Future<void> _initializeFileSave() async {
//     final permissionStatus = await Permission.storage.request();
//     if (permissionStatus == PermissionStatus.granted) {
//       final file = await availablefile();
//       if (PNG.isNotEmpty) {

//       } else {
//         _showNoPngAvailableMessage();
//       }
//     } else {
//       _showPngPermissionDeniedMessage();
//     }
//     return Future.error('PNG initialization failed');
//   }

//   void _showPdfPermissionDeniedMessage() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: const Text(
//             'Access to the Storage was denied. Please enable it in your settings to use this feature.'),
//         backgroundColor: Colors.red,
//       ),
//     );
//   }

// void _showPngPermissionDeniedMessage() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: const Text(
//             'Access to the camera was denied. Please enable it in your settings to use this feature.'),
//         backgroundColor: Colors.red,
//       ),
//     );
//   }
// void _showPNGSavedMessage(BuildContext context, String imagePath) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(
//           'PNG has been saved successfully at the following location: $imagePath'),
//       backgroundColor: Colors.green,
//     ),
//   );
// }

// void _showSavePNGErrorMessage(BuildContext context, dynamic e) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text('An error occurred while saving the image: $e'),
//       backgroundColor: Colors.red,
//     ),
//   );
// }

// void _showPDFSavedMessage(BuildContext context, String pdfPath) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(
//           'PDF has been saved successfully at the following location: $pdfPath'),
//       backgroundColor: Colors.green,
//     ),
//   );
// }

// void _showSavePDFErrorMessage(BuildContext context, dynamic e) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text('An error occurred while saving the PDF file: $e'),
//       backgroundColor: Colors.red,
//     ),
//   );
// }

// Future<Map<String, dynamic>> _capturePng(BuildContext context) async {
//   try {
//     RenderRepaintBoundary boundary =
//         _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
//     ui.Image image = await boundary.toImage();
//     ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//     Uint8List pngBytes = byteData!.buffer.asUint8List();

//     // Get the path to the device's storage directory
//     final directory = (await getApplicationDocumentsDirectory()).path;
//     // Combine the directory path and the image name to get the full image path
//     File imgFile = File('$directory/screenshot.png');
//     // Write the image to a file
//     await imgFile.writeAsBytes(pngBytes);

//     // Create a PDF document.
//     final pdf = pdf_widgets.Document();

//     // Add the image to the PDF document.
//     pdf.addPage(
//       pdf_widgets.Page(
//         build: (pdf_widgets.Context context) => pdf_widgets.Center(
//           child: pdf_widgets.Image(pdf_widgets.MemoryImage(pngBytes)),
//         ),
//       ),
//     );

//     // Save the PDF document to a file.
//     final pdfFile = File('$directory/screenshot.pdf');
//     await pdfFile.writeAsBytes(await pdf.save());
//     _showPDFSavedMessage(context, '$directory/screenshot.pdf');
//     return {'success': true, 'directory': directory};
//   } catch (e) {
//     _showSavePDFErrorMessage(context, e);
//     return {'success': false};
//   }
// }

// Future<void> _saveImage(BuildContext context, String imagePath) async {
//   try {
//     await GallerySaver.saveImage(imagePath, albumName: 'cutie');
//     _showPNGSavedMessage(context, imagePath);
//   } catch (e) {
//     _showSavePNGErrorMessage(context, e);
//   }
// }

// Future<void> _savepdf(BuildContext context, String pdfPath) async {
//   try {
//     await GallerySaver.saveImage(pdfPath, albumName: 'cutie');
//     _showPDFSavedMessage(context, pdfPath); // Corrected method name
//   } catch (e) {
//     _showSavePDFErrorMessage(context, e); // Corrected method name
//   }
// }

// Future<void> _requestPermissions() async {
//   var status = await Permission.storage.status;
//   if (!status.isGranted) {
//     await Permission.storage.request();
//   }
// }

//  ElevatedButton(
//               onPressed: () async {
//                 try {
//                   await _requestPermissions();
//                   Map<String, dynamic> result = await _capturePng(context);
//                   bool pngSaved =
//                       result['success'] ?? false; // Added null check
//                   String directory =
//                       result['directory'] ?? ''; // Added null check
//                   if (pngSaved && directory.isNotEmpty) {
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return AlertDialog(
//                           title: const Text('Choose File Format'),
//                           content: const Text(
//                               'Please choose a file format to save the file.'),
//                           actions: <Widget>[
//                             TextButton(
//                               child: const Text('PNG'),
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                                 _saveImage(
//                                     context, '$directory/screenshot.png');
//                               },
//                             ),
//                             TextButton(
//                               child: const Text('PDF'),
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                                 _savepdf(context, '$directory/screenshot.pdf');
//                               },
//                             ),
//                           ],
//                         );
//                       },
//                     );
//                   }
//                 } catch (e) {
//                   _showSavePDFErrorMessage(context, e.toString());
//                 }
//               },
//               child: const Text('Save file'),
//             ),
// }

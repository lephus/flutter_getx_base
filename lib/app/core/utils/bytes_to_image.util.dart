import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

Future<String> saveImage(Uint8List bytes, String? fileName) async {
  if (fileName == null) {
    fileName = 'image_${DateTime.now().toIso8601String().replaceAll(' ', '')}';
  } else {
    fileName = cleanFileName(fileName);
  }
  // Get the directory for storing images
  final Directory directory = await getApplicationDocumentsDirectory();
  // Create a unique filename
  String filePath = '${directory.path}/${fileName}.png';
  // Write the file
  await File(filePath).writeAsBytes(bytes);
  return filePath;
}

String cleanFileName(String fileName) {
  // Remove invalid characters
  final invalidCharacters = RegExp(r'[<>:"/\\|?*]');
  String cleanedFileName = fileName.replaceAll(invalidCharacters, '');

  // Replace spaces with underscores
  cleanedFileName = cleanedFileName.replaceAll(' ', '_');

  return cleanedFileName;
}

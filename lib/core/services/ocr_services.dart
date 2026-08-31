import 'dart:io';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class OCRService {
  final TextRecognizer _recognizer =
      TextRecognizer(script: TextRecognitionScript.latin);

  Future<String> extractText(File image) async {
    final inputImage = InputImage.fromFile(image);

    final RecognizedText result =
        await _recognizer.processImage(inputImage);

    return result.text;
  }

  void dispose() {
    _recognizer.close();
  }
}

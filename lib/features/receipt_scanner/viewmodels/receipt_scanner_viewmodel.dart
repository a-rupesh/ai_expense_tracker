import 'dart:io';

import 'package:ai_expense_tracker/features/receipt_scanner/services/receipt_ai_services.dart';

import '../../../core/services/ocr_services.dart';
import '../models/receipt_data.dart';


class ReceiptScannerViewModel {
  final OCRService _ocr = OCRService();
  final ReceiptAIService _ai = ReceiptAIService();

  Future<String> recognizeReceipt(File image) async {
    return await _ocr.extractText(image);
  }

  Future<ReceiptData> analyzeReceipt(String ocrText) async {
  return await _ai.extractReceipt(ocrText);
}

  void dispose() {
    _ocr.dispose();
  }

}
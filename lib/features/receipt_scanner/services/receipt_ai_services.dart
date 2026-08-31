import 'dart:convert';

import '../../../services/gemini_service.dart';
import '../models/receipt_data.dart';

class ReceiptAIService {
  final GeminiService gemini = GeminiService();

  Future<ReceiptData> extractReceipt(String ocrText) async {
    final response = await gemini.extractReceiptData(ocrText);

    final cleaned = response
        .replaceAll("```json", "")
        .replaceAll("```", "")
        .trim();

    final json = jsonDecode(cleaned);

    return ReceiptData.fromJson(json);
  }
}
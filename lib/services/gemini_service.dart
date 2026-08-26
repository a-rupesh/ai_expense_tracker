<<<<<<< HEAD
import 'dart:convert';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:ai_expense_tracker/features/ai/models/ai_insight.dart';

import '../config/api_keys.dart';

class GeminiService {
  final GenerativeModel model = GenerativeModel(
    model: "gemini-2.5-flash",
    apiKey: ApiKeys.geminiApiKey,
  );

  /// Test connection
  Future<String> testGemini() async {
    final response = await model.generateContent([
      Content.text("Say hello to Rupesh. You are an AI Expense Advisor."),
    ]);

    return response.text ?? "No response";
  }

  /// Analyze user's expenses
  Future<String> analyzeExpenses(
    List<Map<String, dynamic>> expenses,
    double budget,
  ) async {
    String prompt = """
You are an expert financial advisor.

My monthly budget is ₹${budget.toStringAsFixed(2)}.

These are my expenses:

""";

    for (final expense in expenses) {
      prompt +=
          "- ${expense['category']} | ₹${expense['amount']} | ${expense['note']}\n";
    }

    prompt += """

Please analyze my spending.

Return ONLY these sections:

1. Spending Summary

2. Biggest Spending Category

3. Budget Health

4. Three Savings Tips

5. Final Advice

Keep the response friendly and under 250 words.
""";

    try {
      final response = await model.generateContent([Content.text(prompt)]);

      return response.text ?? "No AI response received.";
    } catch (e) {
      return "Error: $e";
    }
  }

  Future<String> askQuestion(
    String question,
    List<Map<String, dynamic>> expenses,
    double budget,
  ) async {
    String prompt = """
You are FinMate AI, a friendly financial assistant.

Monthly Budget:
₹$budget

Expense List:

""";

    for (var expense in expenses) {
      prompt +=
          "${expense['category']} | ₹${expense['amount']} | ${expense['note']}\n";
    }

    prompt += """

Using ONLY the expense data above, answer this question:

$question

If the information isn't available, politely say you don't have enough information.

Keep the answer under 150 words.
""";

    try {
      final response = await model.generateContent([Content.text(prompt)]);

      return response.text ?? "No response.";
    } catch (e) {
      return e.toString();
    }
  }

  Future<AIInsight> generateInsights({
    required double budget,
    required double spent,
    required Map<String, double> categories,
  }) async {
    final prompt = """
You are FinMate AI.

Analyze this user's finances.

Budget:
₹$budget

Spent:
₹$spent

Category Totals:
$categories

Return ONLY valid JSON.

Example:

{
  "budgetStatus":"₹2500 remaining",
  "topCategory":"Food (56%)",
  "spendingTrend":"Spending is healthy",
  "recommendation":"Reduce restaurant expenses slightly.",
  "healthScore":88
}

Do not include markdown.
Do not wrap the JSON in backticks.
Return JSON only.
""";

    try {
      final response = await model.generateContent([Content.text(prompt)]);

      final text = response.text ?? "";

      final json = jsonDecode(text);

      return AIInsight.fromJson(json);
    } catch (e) {
      return AIInsight(
        budgetStatus: "Unavailable",
        topCategory: "Unavailable",
        spendingTrend: "Unavailable",
        recommendation: "Unable to generate AI insights.",
        healthScore: 0,
      );
    }
  }

  Future<String> extractReceiptData(String receiptText) async {
    final prompt = """
You are an expert receipt parser.

The following text was extracted using OCR.

$receiptText

Return ONLY valid JSON.

Do not explain anything.

Format:

{
  "merchant":"",
  "amount":0,
  "category":"",
  "date":""
}

Rules:

- amount must be numeric

- category should be one of:

Food
Shopping
Travel
Bills
Entertainment
Healthcare
Education
Others

- date format YYYY-MM-DD

If a value cannot be determined, leave it empty.
""";

    final response = await model.generateContent([Content.text(prompt)]);

    return response.text ?? "{}";
  }
}
=======
import 'dart:convert';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:ai_expense_tracker/features/ai/models/ai_insight.dart';

import '../config/api_keys.dart';

class GeminiService {
  final GenerativeModel model = GenerativeModel(
    model: "gemini-2.5-flash",
    apiKey: ApiKeys.geminiApiKey,
  );

  /// Test connection
  Future<String> testGemini() async {
    final response = await model.generateContent([
      Content.text("Say hello to Rupesh. You are an AI Expense Advisor."),
    ]);

    return response.text ?? "No response";
  }

  /// Analyze user's expenses
  Future<String> analyzeExpenses(
    List<Map<String, dynamic>> expenses,
    double budget,
  ) async {
    String prompt = """
You are an expert financial advisor.

My monthly budget is ₹${budget.toStringAsFixed(2)}.

These are my expenses:

""";

    for (final expense in expenses) {
      prompt +=
          "- ${expense['category']} | ₹${expense['amount']} | ${expense['note']}\n";
    }

    prompt += """

Please analyze my spending.

Return ONLY these sections:

1. Spending Summary

2. Biggest Spending Category

3. Budget Health

4. Three Savings Tips

5. Final Advice

Keep the response friendly and under 250 words.
""";

    try {
      final response = await model.generateContent([Content.text(prompt)]);

      return response.text ?? "No AI response received.";
    } catch (e) {
      return "Error: $e";
    }
  }

  Future<String> askQuestion(
    String question,
    List<Map<String, dynamic>> expenses,
    double budget,
  ) async {
    String prompt = """
You are FinMate AI, a friendly financial assistant.

Monthly Budget:
₹$budget

Expense List:

""";

    for (var expense in expenses) {
      prompt +=
          "${expense['category']} | ₹${expense['amount']} | ${expense['note']}\n";
    }

    prompt += """

Using ONLY the expense data above, answer this question:

$question

If the information isn't available, politely say you don't have enough information.

Keep the answer under 150 words.
""";

    try {
      final response = await model.generateContent([Content.text(prompt)]);

      return response.text ?? "No response.";
    } catch (e) {
      return e.toString();
    }
  }

  Future<AIInsight> generateInsights({
    required double budget,
    required double spent,
    required Map<String, double> categories,
  }) async {
    final prompt = """
You are FinMate AI.

Analyze this user's finances.

Budget:
₹$budget

Spent:
₹$spent

Category Totals:
$categories

Return ONLY valid JSON.

Example:

{
  "budgetStatus":"₹2500 remaining",
  "topCategory":"Food (56%)",
  "spendingTrend":"Spending is healthy",
  "recommendation":"Reduce restaurant expenses slightly.",
  "healthScore":88
}

Do not include markdown.
Do not wrap the JSON in backticks.
Return JSON only.
""";

    try {
      final response = await model.generateContent([Content.text(prompt)]);

      final text = response.text ?? "";

      final json = jsonDecode(text);

      return AIInsight.fromJson(json);
    } catch (e) {
      return AIInsight(
        budgetStatus: "Unavailable",
        topCategory: "Unavailable",
        spendingTrend: "Unavailable",
        recommendation: "Unable to generate AI insights.",
        healthScore: 0,
      );
    }
  }

  Future<String> extractReceiptData(String receiptText) async {
    final prompt = """
You are an expert receipt parser.

The following text was extracted using OCR.

$receiptText

Return ONLY valid JSON.

Do not explain anything.

Format:

{
  "merchant":"",
  "amount":0,
  "category":"",
  "date":""
}

Rules:

- amount must be numeric

- category should be one of:

Food
Shopping
Travel
Bills
Entertainment
Healthcare
Education
Others

- date format YYYY-MM-DD

If a value cannot be determined, leave it empty.
""";

    final response = await model.generateContent([Content.text(prompt)]);

    return response.text ?? "{}";
  }
}
>>>>>>> 656d780915e823b4356a161e248a42e061f060ed

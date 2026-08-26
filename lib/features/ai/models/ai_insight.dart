<<<<<<< HEAD
import 'dart:convert';

class AIInsight {
  final String budgetStatus;
  final String topCategory;
  final String spendingTrend;
  final String recommendation;
  final int healthScore;

  AIInsight({
    required this.budgetStatus,
    required this.topCategory,
    required this.spendingTrend,
    required this.recommendation,
    required this.healthScore,
  });

  factory AIInsight.fromJson(Map<String, dynamic> json) {
    return AIInsight(
      budgetStatus: json["budgetStatus"] ?? "",
      topCategory: json["topCategory"] ?? "",
      spendingTrend: json["spendingTrend"] ?? "",
      recommendation: json["recommendation"] ?? "",
      healthScore: json["healthScore"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "budgetStatus": budgetStatus,
      "topCategory": topCategory,
      "spendingTrend": spendingTrend,
      "recommendation": recommendation,
      "healthScore": healthScore,
    };
  }

  String encode() {
    return jsonEncode(toJson());
  }

  factory AIInsight.decode(String source) {
    return AIInsight.fromJson(jsonDecode(source));
  }
=======
import 'dart:convert';

class AIInsight {
  final String budgetStatus;
  final String topCategory;
  final String spendingTrend;
  final String recommendation;
  final int healthScore;

  AIInsight({
    required this.budgetStatus,
    required this.topCategory,
    required this.spendingTrend,
    required this.recommendation,
    required this.healthScore,
  });

  factory AIInsight.fromJson(Map<String, dynamic> json) {
    return AIInsight(
      budgetStatus: json["budgetStatus"] ?? "",
      topCategory: json["topCategory"] ?? "",
      spendingTrend: json["spendingTrend"] ?? "",
      recommendation: json["recommendation"] ?? "",
      healthScore: json["healthScore"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "budgetStatus": budgetStatus,
      "topCategory": topCategory,
      "spendingTrend": spendingTrend,
      "recommendation": recommendation,
      "healthScore": healthScore,
    };
  }

  String encode() {
    return jsonEncode(toJson());
  }

  factory AIInsight.decode(String source) {
    return AIInsight.fromJson(jsonDecode(source));
  }
>>>>>>> 656d780915e823b4356a161e248a42e061f060ed
}
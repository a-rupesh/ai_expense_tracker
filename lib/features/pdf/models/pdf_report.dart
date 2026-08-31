class PdfReport {
  final String userName;
  final double budget;
  final double spent;

  final Map<String, double> categories;

  final List<Map<String, dynamic>> recentExpenses;

  final List<String> aiInsights;

  PdfReport({
    required this.userName,
    required this.budget,
    required this.spent,
    required this.categories,
    required this.recentExpenses,
    required this.aiInsights,
  });
}
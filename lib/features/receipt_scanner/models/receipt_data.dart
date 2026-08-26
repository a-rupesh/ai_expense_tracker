<<<<<<< HEAD
class ReceiptData {
  final String merchant;
  final double amount;
  final String category;
  final String date;

  ReceiptData({
    required this.merchant,
    required this.amount,
    required this.category,
    required this.date,
  });

  factory ReceiptData.fromJson(Map<String, dynamic> json) {
    return ReceiptData(
      merchant: json["merchant"] ?? "",
      amount: (json["amount"] as num?)?.toDouble() ?? 0,
      category: json["category"] ?? "Others",
      date: json["date"] ?? "",
    );
  }

  DateTime? get parsedDate {
  try {
    return DateTime.parse(date);
  } catch (_) {
    return null;
  }
}
=======
class ReceiptData {
  final String merchant;
  final double amount;
  final String category;
  final String date;

  ReceiptData({
    required this.merchant,
    required this.amount,
    required this.category,
    required this.date,
  });

  factory ReceiptData.fromJson(Map<String, dynamic> json) {
    return ReceiptData(
      merchant: json["merchant"] ?? "",
      amount: (json["amount"] as num?)?.toDouble() ?? 0,
      category: json["category"] ?? "Others",
      date: json["date"] ?? "",
    );
  }

  DateTime? get parsedDate {
  try {
    return DateTime.parse(date);
  } catch (_) {
    return null;
  }
}
>>>>>>> 656d780915e823b4356a161e248a42e061f060ed
}
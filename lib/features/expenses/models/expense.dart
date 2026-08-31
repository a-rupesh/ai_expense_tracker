class Expense {
  final String id;
  final double amount;
  final String category;
  final String note;
  final DateTime date;

  Expense({
    required this.id,
    required this.amount,
    required this.category,
    required this.note,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'category': category,
      'note': note,
      'date': date,
    };
  }

  factory Expense.fromFirestore(String id, Map<String, dynamic> json) {
  return Expense(
    id: id,
    amount: (json['amount'] as num).toDouble(),
    category: json['category'],
    note: json['note'],
    date: json['date'].toDate(),
  );
}
}
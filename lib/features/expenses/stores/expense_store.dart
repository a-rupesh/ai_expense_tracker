import 'package:ai_expense_tracker/features/analytics/models/analytics_summary.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ExpenseStore {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addExpense({
    required double amount,
    required String category,
    required String note,
  }) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    await _firestore.collection('users').doc(uid).collection('expenses').add({
      'amount': amount,
      'category': category,
      'note': note,
      'date': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getExpenses() {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('expenses')
        .orderBy('date', descending: true)
        .snapshots();
  }

  Future<void> deleteExpense(String expenseId) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('expenses')
        .doc(expenseId)
        .delete();
  }

  Future<void> updateExpense({
    required String expenseId,
    required double amount,
    required String category,
    required String note,
  }) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('expenses')
        .doc(expenseId)
        .update({'amount': amount, 'category': category, 'note': note});
  }

  Future<double> getTotalSpent() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final snapshot =
        await FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .collection("expenses")
            .get();

    double total = 0;

    for (final doc in snapshot.docs) {
      total += (doc["amount"] as num).toDouble();
    }

    return total;
  }

  Future<void> saveBudget(double budget) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'budget': budget,
    }, SetOptions(merge: true));
  }

  Future<double> getBudget() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final doc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (!doc.exists) return 0;

    final data = doc.data();

    if (data == null) return 0;

    return (data['budget'] ?? 0).toDouble();
  }

  Stream<QuerySnapshot> getRecentExpenses() {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('expenses')
        .orderBy('date', descending: true)
        .limit(5)
        .snapshots();
  }

  Future<List<Map<String, dynamic>>> getAllExpenses() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final snapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('expenses')
            .orderBy('date', descending: true)
            .get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<AnalyticsSummary> getAnalyticsSummary() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final snapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('expenses')
            .get();

    double total = 0;
    double highest = 0;

    for (var doc in snapshot.docs) {
      final amount = (doc['amount'] as num).toDouble();

      total += amount;

      if (amount > highest) {
        highest = amount;
      }
    }

    final count = snapshot.docs.length;

    final average = count == 0 ? 0.0 : total / count;

    return AnalyticsSummary(
      totalSpent: total,
      transactionCount: count,
      highestExpense: highest,
      averageExpense: average,
    );
  }

  Future<Map<String, double>> getCategoryTotals() async {
  final uid = FirebaseAuth.instance.currentUser!.uid;

  final snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('expenses')
      .get();

  final Map<String, double> totals = {};

  for (final doc in snapshot.docs) {
    final data = doc.data();

    final category = data['category'] ?? "Others";

    final amount = (data['amount'] as num).toDouble();

    totals.update(
      category,
      (value) => value + amount,
      ifAbsent: () => amount,
    );
  }

  return totals;
}

Future<Map<String, double>> getWeeklySpending() async {
  final uid = FirebaseAuth.instance.currentUser!.uid;

  final snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('expenses')
      .get();

  final Map<String, double> weekly = {
    "Mon": 0,
    "Tue": 0,
    "Wed": 0,
    "Thu": 0,
    "Fri": 0,
    "Sat": 0,
    "Sun": 0,
  };

  for (final doc in snapshot.docs) {
    final data = doc.data();

    final Timestamp timestamp = data["date"];

    final DateTime date = timestamp.toDate();

    final amount = (data["amount"] as num).toDouble();

    String day = "";

    switch (date.weekday) {
      case DateTime.monday:
        day = "Mon";
        break;
      case DateTime.tuesday:
        day = "Tue";
        break;
      case DateTime.wednesday:
        day = "Wed";
        break;
      case DateTime.thursday:
        day = "Thu";
        break;
      case DateTime.friday:
        day = "Fri";
        break;
      case DateTime.saturday:
        day = "Sat";
        break;
      default:
        day = "Sun";
    }

    weekly[day] = weekly[day]! + amount;
  }

  return weekly;
}

Future<Map<String, double>> getMonthlySpending() async {
  final uid = FirebaseAuth.instance.currentUser!.uid;

  final snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('expenses')
      .get();

  final Map<String, double> monthly = {
    "Jan": 0,
    "Feb": 0,
    "Mar": 0,
    "Apr": 0,
    "May": 0,
    "Jun": 0,
    "Jul": 0,
    "Aug": 0,
    "Sep": 0,
    "Oct": 0,
    "Nov": 0,
    "Dec": 0,
  };

  for (final doc in snapshot.docs) {
    final data = doc.data();

    final Timestamp timestamp = data["date"];

    final DateTime date = timestamp.toDate();

    final amount = (data["amount"] as num).toDouble();

    const months = [
      "Jan","Feb","Mar","Apr","May","Jun",
      "Jul","Aug","Sep","Oct","Nov","Dec"
    ];

    monthly[months[date.month - 1]] =
        monthly[months[date.month - 1]]! + amount;
  }

  return monthly;
}
}

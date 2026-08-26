<<<<<<< HEAD
import 'package:ai_expense_tracker/features/analytics/models/analytics_summary.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../stores/expense_store.dart';

class ExpenseViewModel {
  final ExpenseStore _store = ExpenseStore();

  Future<void> saveExpense({
    required double amount,
    required String category,
    required String note,
  }) async {
    await _store.addExpense(
      amount: amount,
      category: category,
      note: note,
    );
  }
  Stream<QuerySnapshot> getExpenses() {
  return _store.getExpenses();
}
Future<void> deleteExpense(String expenseId) async {
  await _store.deleteExpense(expenseId);
}

Future<void> updateExpense({
  required String expenseId,
  required double amount,
  required String category,
  required String note,
}) async {
  await _store.updateExpense(
    expenseId: expenseId,
    amount: amount,
    category: category,
    note: note,
  );
}
Future<double> getTotalSpent() {
  return _store.getTotalSpent();
}

Future<void> saveBudget(double budget) async {
  await _store.saveBudget(budget);
}

Future<double> getBudget() async {
  return _store.getBudget();
}

Stream<QuerySnapshot> getRecentExpenses() {
  return _store.getRecentExpenses();
}

Future<List<Map<String, dynamic>>> getAllExpenses() {
  return _store.getAllExpenses();
}

Future<AnalyticsSummary> getAnalyticsSummary() {
  return _store.getAnalyticsSummary();
}

Future<Map<String, double>> getCategoryTotals() {
  return _store.getCategoryTotals();
}

Future<Map<String, double>> getWeeklySpending() {
  return _store.getWeeklySpending();
}

Future<Map<String, double>> getMonthlySpending() {
  return _store.getMonthlySpending();
}
=======
import 'package:ai_expense_tracker/features/analytics/models/analytics_summary.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../stores/expense_store.dart';

class ExpenseViewModel {
  final ExpenseStore _store = ExpenseStore();

  Future<void> saveExpense({
    required double amount,
    required String category,
    required String note,
  }) async {
    await _store.addExpense(
      amount: amount,
      category: category,
      note: note,
    );
  }
  Stream<QuerySnapshot> getExpenses() {
  return _store.getExpenses();
}
Future<void> deleteExpense(String expenseId) async {
  await _store.deleteExpense(expenseId);
}

Future<void> updateExpense({
  required String expenseId,
  required double amount,
  required String category,
  required String note,
}) async {
  await _store.updateExpense(
    expenseId: expenseId,
    amount: amount,
    category: category,
    note: note,
  );
}
Future<double> getTotalSpent() {
  return _store.getTotalSpent();
}

Future<void> saveBudget(double budget) async {
  await _store.saveBudget(budget);
}

Future<double> getBudget() async {
  return _store.getBudget();
}

Stream<QuerySnapshot> getRecentExpenses() {
  return _store.getRecentExpenses();
}

Future<List<Map<String, dynamic>>> getAllExpenses() {
  return _store.getAllExpenses();
}

Future<AnalyticsSummary> getAnalyticsSummary() {
  return _store.getAnalyticsSummary();
}

Future<Map<String, double>> getCategoryTotals() {
  return _store.getCategoryTotals();
}

Future<Map<String, double>> getWeeklySpending() {
  return _store.getWeeklySpending();
}

Future<Map<String, double>> getMonthlySpending() {
  return _store.getMonthlySpending();
}
>>>>>>> 656d780915e823b4356a161e248a42e061f060ed
}
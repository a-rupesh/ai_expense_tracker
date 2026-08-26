<<<<<<< HEAD
import 'package:flutter/material.dart';
import '../../expenses/viewmodels/expense_viewmodel.dart';
import '../models/analytics_summary.dart';

class AnalyticsViewModel {
  final ExpenseViewModel _expenseVM = ExpenseViewModel();

  Future<AnalyticsSummary> loadSummary() {
    return _expenseVM.getAnalyticsSummary();
  }

  Future<Map<String, double>> loadCategoryTotals() {
    return _expenseVM.getCategoryTotals();
  }

  Color getCategoryColor(int index) {
    const colors = [
      Colors.orange,
      Colors.green,
      Colors.blue,
      Colors.red,
      Colors.purple,
      Colors.teal,
      Colors.brown,
      Colors.indigo,
    ];

    return colors[index % colors.length];
  }

  Future<Map<String, double>> loadWeeklySpending() {
  return _expenseVM.getWeeklySpending();
}

Future<Map<String, double>> loadMonthlySpending() {
  return _expenseVM.getMonthlySpending();
}
=======
import 'package:flutter/material.dart';
import '../../expenses/viewmodels/expense_viewmodel.dart';
import '../models/analytics_summary.dart';

class AnalyticsViewModel {
  final ExpenseViewModel _expenseVM = ExpenseViewModel();

  Future<AnalyticsSummary> loadSummary() {
    return _expenseVM.getAnalyticsSummary();
  }

  Future<Map<String, double>> loadCategoryTotals() {
    return _expenseVM.getCategoryTotals();
  }

  Color getCategoryColor(int index) {
    const colors = [
      Colors.orange,
      Colors.green,
      Colors.blue,
      Colors.red,
      Colors.purple,
      Colors.teal,
      Colors.brown,
      Colors.indigo,
    ];

    return colors[index % colors.length];
  }

  Future<Map<String, double>> loadWeeklySpending() {
  return _expenseVM.getWeeklySpending();
}

Future<Map<String, double>> loadMonthlySpending() {
  return _expenseVM.getMonthlySpending();
}
>>>>>>> 656d780915e823b4356a161e248a42e061f060ed
}
import 'package:ai_expense_tracker/core/services/user_services.dart';
import 'package:ai_expense_tracker/features/ai/models/ai_insight.dart';
import 'package:ai_expense_tracker/features/ai/viewmodels/ai_insights_viewmodel.dart';
import 'package:ai_expense_tracker/features/expenses/viewmodels/expense_viewmodel.dart';

class DashboardViewModel {
  final ExpenseViewModel _expenseVM = ExpenseViewModel();
  final AIInsightsViewModel _aiVM = AIInsightsViewModel();
  final UserService _userService = UserService();

  Future<String> getUserName() {
    return _userService.getUserName();
  }

  Future<double> getBudget() {
    return _expenseVM.getBudget();
  }

  Future<double> getSpent() {
    return _expenseVM.getTotalSpent();
  }

  Future<AIInsight> getInsights() {
    return _aiVM.getInsights();
  }

  Future<void> saveBudget(double budget) {
    return _expenseVM.saveBudget(budget);
  }

  Future<void> clearAICache() {
  return _aiVM.clearCache();
}

Future<DateTime?> lastUpdated() {
  return _aiVM.lastUpdated();
}
}

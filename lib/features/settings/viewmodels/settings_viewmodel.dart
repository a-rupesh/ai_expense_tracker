<<<<<<< HEAD
import 'package:ai_expense_tracker/features/expenses/stores/expense_store.dart';

class SettingsViewModel {
  final ExpenseStore _expenseStore = ExpenseStore();

  Future<double> getBudget() {
    return _expenseStore.getBudget();
  }

  Future<void> saveBudget(double budget) {
    return _expenseStore.saveBudget(budget);
  }

  Future<double> getTotalSpent() {
    return _expenseStore.getTotalSpent();
  }
=======
import 'package:ai_expense_tracker/features/expenses/stores/expense_store.dart';

class SettingsViewModel {
  final ExpenseStore _expenseStore = ExpenseStore();

  Future<double> getBudget() {
    return _expenseStore.getBudget();
  }

  Future<void> saveBudget(double budget) {
    return _expenseStore.saveBudget(budget);
  }

  Future<double> getTotalSpent() {
    return _expenseStore.getTotalSpent();
  }
>>>>>>> 656d780915e823b4356a161e248a42e061f060ed
}
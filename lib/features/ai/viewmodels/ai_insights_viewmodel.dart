<<<<<<< HEAD
import 'package:ai_expense_tracker/core/services/ai_cache_services.dart';
import '../../../services/gemini_service.dart';
import '../models/ai_insight.dart';
import '../../expenses/viewmodels/expense_viewmodel.dart';

class AIInsightsViewModel {
  final ExpenseViewModel expenseVM = ExpenseViewModel();

  final GeminiService gemini = GeminiService();

  final AICacheService cache = AICacheService();

  Future<AIInsight> getInsights({
    bool forceRefresh = false,
  }) async {

    if (!forceRefresh) {
      final cached = await cache.loadInsights();

      if (cached != null) {
        return AIInsight.decode(cached);
      }
    }

    final budget = await expenseVM.getBudget();

    final spent = await expenseVM.getTotalSpent();

    final categories = await expenseVM.getCategoryTotals();

    final insight = await gemini.generateInsights(
      budget: budget,
      spent: spent,
      categories: categories,
    );

    await cache.saveInsights(
      insight.encode(),
    );

    return insight;
  }

  Future<void> clearCache() async {
    await cache.clear();
  }

  Future<DateTime?> lastUpdated() {
    return cache.lastUpdated();
  }
=======
import 'package:ai_expense_tracker/core/services/ai_cache_services.dart';
import '../../../services/gemini_service.dart';
import '../models/ai_insight.dart';
import '../../expenses/viewmodels/expense_viewmodel.dart';

class AIInsightsViewModel {
  final ExpenseViewModel expenseVM = ExpenseViewModel();

  final GeminiService gemini = GeminiService();

  final AICacheService cache = AICacheService();

  Future<AIInsight> getInsights({
    bool forceRefresh = false,
  }) async {

    if (!forceRefresh) {
      final cached = await cache.loadInsights();

      if (cached != null) {
        return AIInsight.decode(cached);
      }
    }

    final budget = await expenseVM.getBudget();

    final spent = await expenseVM.getTotalSpent();

    final categories = await expenseVM.getCategoryTotals();

    final insight = await gemini.generateInsights(
      budget: budget,
      spent: spent,
      categories: categories,
    );

    await cache.saveInsights(
      insight.encode(),
    );

    return insight;
  }

  Future<void> clearCache() async {
    await cache.clear();
  }

  Future<DateTime?> lastUpdated() {
    return cache.lastUpdated();
  }
>>>>>>> 656d780915e823b4356a161e248a42e061f060ed
}
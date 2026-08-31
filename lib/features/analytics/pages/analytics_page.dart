import 'package:flutter/material.dart';
import 'package:ai_expense_tracker/features/analytics/viewmodels/analytics_viewmodel.dart';
import 'package:ai_expense_tracker/features/analytics/widgets/category_pie_chart.dart';
import 'package:ai_expense_tracker/features/analytics/widgets/summary_card.dart';
import '../widgets/category_breakdown_tile.dart';
import '../widgets/weekly_bar_chart.dart';
import '../widgets/monthly_line_chart.dart';

class AnalyticsPage extends StatelessWidget {
  AnalyticsPage({super.key});

  final AnalyticsViewModel viewModel = AnalyticsViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Analytics"), centerTitle: true),
      body: FutureBuilder(
        future: viewModel.loadSummary(),
        builder: (context, summarySnapshot) {
          if (summarySnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (summarySnapshot.hasError) {
            return Center(child: Text(summarySnapshot.error.toString()));
          }

          if (!summarySnapshot.hasData) {
            return const Center(child: Text("No Analytics Available"));
          }

          final summary = summarySnapshot.data!;

          return RefreshIndicator(
            onRefresh: () async {},
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// =======================
                  /// OVERVIEW
                  /// =======================
                  const Text(
                    "Overview",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.95,
                    children: [
                      SummaryCard(
                        title: "Total Spent",
                        value: "â‚¹${summary.totalSpent.toStringAsFixed(2)}",
                        icon: Icons.account_balance_wallet,
                        color: Colors.green,
                      ),

                      SummaryCard(
                        title: "Transactions",
                        value: summary.transactionCount.toString(),
                        icon: Icons.receipt_long,
                        color: Colors.blue,
                      ),

                      SummaryCard(
                        title: "Highest Expense",
                        value: "â‚¹${summary.highestExpense.toStringAsFixed(2)}",
                        icon: Icons.trending_up,
                        color: Colors.red,
                      ),

                      SummaryCard(
                        title: "Average Expense",
                        value: "â‚¹${summary.averageExpense.toStringAsFixed(2)}",
                        icon: Icons.analytics,
                        color: Colors.orange,
                      ),
                    ],
                  ),

                  const SizedBox(height: 35),

                  /// =======================
                  /// PIE CHART
                  /// =======================
                  const Text(
                    "Spending by Category",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  FutureBuilder<Map<String, double>>(
                    future: viewModel.loadCategoryTotals(),
                    builder: (context, pieSnapshot) {
                      if (pieSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (pieSnapshot.hasError) {
                        return Center(
                          child: Text(pieSnapshot.error.toString()),
                        );
                      }

                      return CategoryPieChart(data: pieSnapshot.data ?? {});
                    },
                  ),

                  const SizedBox(height: 30),

                  const SizedBox(height: 30),

                  const Text(
                    "Category Breakdown",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 15),

                  FutureBuilder<Map<String, double>>(
                    future: viewModel.loadCategoryTotals(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const SizedBox();
                      }

                      final data = snapshot.data!;

                      final total = data.values.fold(
                        0.0,
                        (sum, value) => sum + value,
                      );

                      int index = 0;

                      return Column(
                        children:
                            data.entries.map((entry) {
                              final double percentage =
                                  total == 0.0
                                      ? 0.0
                                      : (entry.value / total) * 100;

                              final tile = CategoryBreakdownTile(
                                category: entry.key,
                                amount: entry.value,
                                percentage: percentage,
                                color: viewModel.getCategoryColor(index),
                              );

                              index++;

                              return tile;
                            }).toList(),
                      );
                    },
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Weekly Spending",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  FutureBuilder<Map<String, double>>(
                    future: viewModel.loadWeeklySpending(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const SizedBox();
                      }

                      return WeeklyBarChart(weeklyData: snapshot.data!);
                    },
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Monthly Trend",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  FutureBuilder<Map<String, double>>(
                    future: viewModel.loadMonthlySpending(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      }

                      if (!snapshot.hasData) {
                        return const SizedBox();
                      }

                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: MonthlyLineChart(monthlyData: snapshot.data!),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

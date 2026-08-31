import 'package:ai_expense_tracker/core/services/user_services.dart';
import 'package:ai_expense_tracker/core/widgets/dashboard_loading.dart';
import 'package:ai_expense_tracker/features/ai/widgets/ai_loading_card.dart';
import 'package:ai_expense_tracker/features/dashboard/viewmodels/dashboard_viewmodel.dart';
import 'package:ai_expense_tracker/features/dashboard/widgets/dashboard_header.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ai_expense_tracker/features/dashboard/widgets/recent_expenses.dart';
import '../../routes/app_routes.dart';
import 'package:ai_expense_tracker/features/ai/models/ai_insight.dart';
import 'package:ai_expense_tracker/features/dashboard/widgets/budget_progress_card.dart';
import 'package:ai_expense_tracker/features/dashboard/widgets/finmate_ai_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DashboardViewModel dashboardVM = DashboardViewModel();

  double budget = 0;
  double spent = 0;

  bool loading = true;
  String formatTime(DateTime? date) {
    if (date == null) {
      return "Never updated";
    }

    final difference = DateTime.now().difference(date);

    if (difference.inMinutes < 1) {
      return "Updated just now";
    }

    if (difference.inMinutes < 60) {
      return "Updated ${difference.inMinutes} min ago";
    }

    if (difference.inHours < 24) {
      return "Updated ${difference.inHours} hr ago";
    }

    return "Updated ${difference.inDays} day ago";
  }

  @override
  void initState() {
    super.initState();
    _loadDashboard();
  }

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }

  Future<void> _loadDashboard() async {
    setState(() {
      loading = true;
    });

    budget = await dashboardVM.getBudget();
    spent = await dashboardVM.getSpent();

    if (!mounted) return;

    setState(() {
      loading = false;
    });
  }

  Future<void> _showBudgetDialog() async {
    final controller = TextEditingController(
      text: budget == 0 ? "" : budget.toStringAsFixed(0),
    );

    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Monthly Budget"),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: "Enter your monthly budget",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                final value = double.tryParse(controller.text.trim()) ?? 0;

                await dashboardVM.saveBudget(value);

                if (!mounted) return;

                Navigator.pop(context);

                _loadDashboard();
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  double get remaining {
    return budget - spent;
  }

  double get progress {
    if (budget <= 0) return 0;

    final value = spent / budget;

    if (value > 1) return 1;

    return value;
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text("FinMate AI"),
        centerTitle: true,

        actions: [
          IconButton(
            tooltip: "Settings",
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),

          IconButton(
            tooltip: "Logout",
            onPressed: () => _logout(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.pushNamed(context, AppRoutes.addExpense);

          _loadDashboard();
        },
        icon: const Icon(Icons.add),
        label: const Text("Add Expense"),
      ),

      body:
          loading
              ? const DashboardLoading()
              : RefreshIndicator(
                onRefresh: _loadDashboard,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Header
                      /// Header
                      FutureBuilder<String>(
                        future: UserService().getUserName(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const DashboardHeader(
                              userName: "Loading...",
                            );
                          }

                          return DashboardHeader(
                            userName: snapshot.data ?? "User",
                          );
                        },
                      ),

                      const SizedBox(height: 24),

                      FutureBuilder<double>(
                        future: dashboardVM.getBudget(),
                        builder: (context, budgetSnapshot) {
                          return FutureBuilder<double>(
                            future: dashboardVM.getSpent(),
                            builder: (context, spentSnapshot) {
                              if (!budgetSnapshot.hasData ||
                                  !spentSnapshot.hasData) {
                                return const DashboardLoading();
                              }

                              return GestureDetector(
                                onTap: _showBudgetDialog,
                                child: BudgetProgressCard(
                                  budget: budgetSnapshot.data!,
                                  spent: spentSnapshot.data!,
                                ),
                              );
                            },
                          );
                        },
                      ),

                      const SizedBox(height: 30),

                      const Text(
                        "Recent Expenses",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      const RecentExpenses(),

                      const SizedBox(height: 30),

                      const Text(
                        "Smart Insights",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      FutureBuilder<AIInsight>(
                        future: dashboardVM.getInsights(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const AILoadingCard();
                          }

                          if (snapshot.hasError) {
                            return Card(
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Text(snapshot.error.toString()),
                              ),
                            );
                          }

                          if (!snapshot.hasData) {
                            return const SizedBox();
                          }

                          return FutureBuilder<DateTime?>(
                            future: dashboardVM.lastUpdated(),
                            builder: (context, timeSnapshot) {
                              return FinMateAICard(
                                insight: snapshot.data!,

                                updatedText: formatTime(timeSnapshot.data),

                                onRefresh: () async {
                                  await dashboardVM.clearAICache();

                                  setState(() {});
                                },
                              );
                            },
                          );
                        },
                      ),

                      const SizedBox(height: 30),

                      const Text(
                        "Quick Actions",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                        childAspectRatio: 1.2,
                        children: [
                          _actionCard(
                            context,
                            title: "Add Expense",
                            icon: Icons.add_circle_outline,
                            route: AppRoutes.addExpense,
                            onReturn: _loadDashboard,
                          ),

                          _actionCard(
                            context,
                            title: "Expenses",
                            icon: Icons.receipt_long,
                            route: AppRoutes.expenses,
                            onReturn: _loadDashboard,
                          ),

                          _actionCard(
                            context,
                            title: "Analytics",
                            icon: Icons.bar_chart,
                            route: AppRoutes.analytics,
                            onReturn: _loadDashboard,
                          ),

                          _actionCard(
                            context,
                            title: "AI Chat",
                            icon: Icons.auto_awesome,
                            route: AppRoutes.aiChat,
                            onReturn: _loadDashboard,
                          ),

                          _actionCard(
                            context,
                            title: "Scan Receipt",
                            icon: Icons.document_scanner,
                            route: AppRoutes.receiptScanner,
                            onReturn: _loadDashboard,
                          ),

                          _actionCard(
                            context,
                            title: "Settings",
                            icon: Icons.settings,
                            route: AppRoutes.settings,
                            onReturn: _loadDashboard,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
    );
  }

  static Widget _actionCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required String route,
    VoidCallback? onReturn,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () async {
        await Navigator.pushNamed(context, route);

        onReturn?.call();
      },
      child: Card(
        elevation: 2,
        color: Theme.of(context).cardColor,
        shadowColor: Theme.of(context).shadowColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

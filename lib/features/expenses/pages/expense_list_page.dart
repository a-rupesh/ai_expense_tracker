<<<<<<< HEAD
import 'package:ai_expense_tracker/features/expenses/models/expense.dart';
import 'package:ai_expense_tracker/features/expenses/pages/add_expense_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../viewmodels/expense_viewmodel.dart';

class ExpenseListPage extends StatelessWidget {
  const ExpenseListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = ExpenseViewModel();

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Expenses"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: viewModel.getExpenses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No expenses added yet.",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          final expenses = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: expenses.length,
            itemBuilder: (context, index) {
              final expense =
                  expenses[index].data() as Map<String, dynamic>;

              final expenseModel = Expense.fromFirestore(
                expenses[index].id,
                expense,
              );

              return Dismissible(
                key: Key(expenses[index].id),

                direction: DismissDirection.endToStart,

                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),

                confirmDismiss: (_) async {
                  return await showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Delete Expense"),
                      content: const Text(
                        "Are you sure you want to delete this expense?",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () =>
                              Navigator.pop(context, false),
                          child: const Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: () =>
                              Navigator.pop(context, true),
                          child: const Text("Delete"),
                        ),
                      ],
                    ),
                  );
                },

                onDismissed: (_) async {
                  await viewModel.deleteExpense(expenses[index].id);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Expense deleted"),
                    ),
                  );
                },

                child: Card(
                  elevation: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddExpensePage(
                            expense: expenseModel,
                          ),
                        ),
                      );
                    },

                    contentPadding: const EdgeInsets.all(16),

                    leading: CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.blue.shade100,
                      child: Icon(
                        _getCategoryIcon(expense["category"]),
                        color: Colors.blue,
                      ),
                    ),

                    title: Text(
                      expense["category"],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),

                    subtitle: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),

                        Text(expense["note"]),

                        const SizedBox(height: 8),

                        Text(
                          _formatDate(
                            (expense["date"] as Timestamp)
                                .toDate(),
                          ),
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    trailing: Text(
                      "₹${expense["amount"]}",
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  static IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case "food":
        return Icons.restaurant;

      case "travel":
        return Icons.directions_bus;

      case "shopping":
        return Icons.shopping_bag;

      case "bills":
        return Icons.receipt_long;

      case "health":
        return Icons.favorite;

      case "entertainment":
        return Icons.movie;

      default:
        return Icons.account_balance_wallet;
    }
  }

  static String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
=======
import 'package:ai_expense_tracker/features/expenses/models/expense.dart';
import 'package:ai_expense_tracker/features/expenses/pages/add_expense_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../viewmodels/expense_viewmodel.dart';

class ExpenseListPage extends StatelessWidget {
  const ExpenseListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = ExpenseViewModel();

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Expenses"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: viewModel.getExpenses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No expenses added yet.",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          final expenses = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: expenses.length,
            itemBuilder: (context, index) {
              final expense =
                  expenses[index].data() as Map<String, dynamic>;

              final expenseModel = Expense.fromFirestore(
                expenses[index].id,
                expense,
              );

              return Dismissible(
                key: Key(expenses[index].id),

                direction: DismissDirection.endToStart,

                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),

                confirmDismiss: (_) async {
                  return await showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Delete Expense"),
                      content: const Text(
                        "Are you sure you want to delete this expense?",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () =>
                              Navigator.pop(context, false),
                          child: const Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: () =>
                              Navigator.pop(context, true),
                          child: const Text("Delete"),
                        ),
                      ],
                    ),
                  );
                },

                onDismissed: (_) async {
                  await viewModel.deleteExpense(expenses[index].id);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Expense deleted"),
                    ),
                  );
                },

                child: Card(
                  elevation: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddExpensePage(
                            expense: expenseModel,
                          ),
                        ),
                      );
                    },

                    contentPadding: const EdgeInsets.all(16),

                    leading: CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.blue.shade100,
                      child: Icon(
                        _getCategoryIcon(expense["category"]),
                        color: Colors.blue,
                      ),
                    ),

                    title: Text(
                      expense["category"],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),

                    subtitle: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),

                        Text(expense["note"]),

                        const SizedBox(height: 8),

                        Text(
                          _formatDate(
                            (expense["date"] as Timestamp)
                                .toDate(),
                          ),
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    trailing: Text(
                      "₹${expense["amount"]}",
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  static IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case "food":
        return Icons.restaurant;

      case "travel":
        return Icons.directions_bus;

      case "shopping":
        return Icons.shopping_bag;

      case "bills":
        return Icons.receipt_long;

      case "health":
        return Icons.favorite;

      case "entertainment":
        return Icons.movie;

      default:
        return Icons.account_balance_wallet;
    }
  }

  static String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
>>>>>>> 656d780915e823b4356a161e248a42e061f060ed
}
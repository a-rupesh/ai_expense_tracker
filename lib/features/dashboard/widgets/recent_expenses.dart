<<<<<<< HEAD
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../expenses/viewmodels/expense_viewmodel.dart';

class RecentExpenses extends StatelessWidget {
  const RecentExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = ExpenseViewModel();

    return StreamBuilder<QuerySnapshot>(
      stream: viewModel.getRecentExpenses(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final docs = snapshot.data!.docs;

        if (docs.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Text("No recent expenses"),
            ),
          );
        }

        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            children: [
              for (var doc in docs)
                ListTile(
                  leading: CircleAvatar(
                    child: Icon(
                      _icon(doc["category"]),
                    ),
                  ),
                  title: Text(doc["category"]),
                  subtitle: Text(doc["note"]),
                  trailing: Text(
                    "₹${doc["amount"]}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  static IconData _icon(String category) {
    switch (category.toLowerCase()) {
      case "food":
        return Icons.restaurant;

      case "travel":
        return Icons.directions_bus;

      case "shopping":
        return Icons.shopping_bag;

      case "health":
        return Icons.favorite;

      case "bills":
        return Icons.receipt;

      default:
        return Icons.account_balance_wallet;
    }
  }
=======
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../expenses/viewmodels/expense_viewmodel.dart';

class RecentExpenses extends StatelessWidget {
  const RecentExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = ExpenseViewModel();

    return StreamBuilder<QuerySnapshot>(
      stream: viewModel.getRecentExpenses(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final docs = snapshot.data!.docs;

        if (docs.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Text("No recent expenses"),
            ),
          );
        }

        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            children: [
              for (var doc in docs)
                ListTile(
                  leading: CircleAvatar(
                    child: Icon(
                      _icon(doc["category"]),
                    ),
                  ),
                  title: Text(doc["category"]),
                  subtitle: Text(doc["note"]),
                  trailing: Text(
                    "₹${doc["amount"]}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  static IconData _icon(String category) {
    switch (category.toLowerCase()) {
      case "food":
        return Icons.restaurant;

      case "travel":
        return Icons.directions_bus;

      case "shopping":
        return Icons.shopping_bag;

      case "health":
        return Icons.favorite;

      case "bills":
        return Icons.receipt;

      default:
        return Icons.account_balance_wallet;
    }
  }
>>>>>>> 656d780915e823b4356a161e248a42e061f060ed
}
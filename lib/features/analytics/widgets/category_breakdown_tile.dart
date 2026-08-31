import 'package:flutter/material.dart';

class CategoryBreakdownTile extends StatelessWidget {
  final String category;
  final double amount;
  final double percentage;
  final Color color;

  const CategoryBreakdownTile({
    super.key,
    required this.category,
    required this.amount,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          radius: 10,
        ),
        title: Text(
          category,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          "${percentage.toStringAsFixed(1)}%",
        ),
        trailing: Text(
          "â‚¹${amount.toStringAsFixed(2)}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

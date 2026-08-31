import 'package:ai_expense_tracker/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BudgetProgressCard extends StatelessWidget {
  final double budget;
  final double spent;

  /// NEW
  final String title;
  final bool showTitle;
  final bool showEditButton;
  final VoidCallback? onEdit;

  const BudgetProgressCard({
    super.key,
    required this.budget,
    required this.spent,

    this.title = "Budget Progress",
    this.showTitle = true,
    this.showEditButton = false,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final remaining = (budget - spent).clamp(0, budget);

    final progress =
        budget <= 0 ? 0.0 : (spent / budget).clamp(0.0, 1.0);

    Color progressColor;

    if (progress < 0.7) {
      progressColor = Colors.green;
    } else if (progress < 0.9) {
      progressColor = Colors.orange;
    } else {
      progressColor = Colors.red;
    }

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            if (showTitle)
              Row(
                children: [

                  const Icon(
                    Icons.account_balance_wallet_rounded,
                    color: AppColors.electricAqua,
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  if (showEditButton)
                    IconButton(
                      tooltip: "Edit Budget",
                      onPressed: onEdit,
                      icon: const Icon(Icons.edit),
                    ),
                ],
              ),

            if (showTitle)
              const SizedBox(height: 20),

            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: TweenAnimationBuilder<double>(
                tween: Tween(
                  begin: 0,
                  end: progress,
                ),
                duration: const Duration(milliseconds: 1200),
                curve: Curves.easeInOut,
                builder: (context, value, child) {
                  return LinearProgressIndicator(
                    value: value,
                    minHeight: 12,
                    backgroundColor:
                        Theme.of(context).dividerColor.withOpacity(0.25),
                    valueColor:
                        AlwaysStoppedAnimation(progressColor),
                  );
                },
              ),
            ),

            const SizedBox(height: 18),

            Center(
              child: Text(
                "${(progress * 100).toStringAsFixed(0)}%",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: progressColor,
                ),
              ),
            ),

            const SizedBox(height: 22),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [

                Expanded(
                  child: _infoTile(
                    context,
                    "Remaining",
                    "â‚¹${remaining.toStringAsFixed(2)}",
                  ),
                ),

                Expanded(
                  child: _infoTile(
                    context,
                    "Spent",
                    "â‚¹${spent.toStringAsFixed(2)}",
                    end: true,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            Text(
              "Monthly Budget : â‚¹${budget.toStringAsFixed(2)}",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(
    BuildContext context,
    String title,
    String value, {
    bool end = false,
  }) {
    return Column(
      crossAxisAlignment:
          end ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [

        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(
                color: Colors.grey,
              ),
        ),

        const SizedBox(height: 6),

        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

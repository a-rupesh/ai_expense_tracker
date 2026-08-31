import 'package:flutter/material.dart';
import 'package:ai_expense_tracker/features/ai/models/ai_insight.dart';

class FinMateAICard extends StatelessWidget {
  final AIInsight insight;

  final VoidCallback onRefresh;

  final String updatedText;

  const FinMateAICard({
    super.key,
    required this.insight,
    required this.onRefresh,
    required this.updatedText,
  });

  @override
  Widget build(BuildContext context) {
    final score = insight.healthScore.clamp(0, 100);

    Color scoreColor;

    if (score >= 80) {
      scoreColor = Colors.green;
    } else if (score >= 50) {
      scoreColor = Colors.orange;
    } else {
      scoreColor = Colors.red;
    }

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Header
            Row(
  children: [

    const Icon(
      Icons.auto_awesome,
      color: Colors.deepPurple,
      size: 30,
    ),

    const SizedBox(width: 10),

    const Expanded(
      child: Text(
        "FinMate AI",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

    IconButton(
      onPressed: onRefresh,
      icon: const Icon(
        Icons.refresh,
      ),
    ),
  ],
),

            const SizedBox(height: 22),

            /// Health Score
            const Text(
              "Financial Health",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 10),

            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: score / 100,
                minHeight: 10,
                color: scoreColor,
                backgroundColor: Colors.grey.shade300,
              ),
            ),

            const SizedBox(height: 10),

            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "$score / 100",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: scoreColor,
                ),
              ),
            ),

            const Divider(height: 35),

            _item(
              Icons.account_balance_wallet,
              Colors.green,
              "Budget",
              insight.budgetStatus,
            ),

            const SizedBox(height: 18),

            _item(
              Icons.restaurant,
              Colors.orange,
              "Top Category",
              insight.topCategory,
            ),

            const SizedBox(height: 18),

            _item(
              Icons.trending_up,
              Colors.blue,
              "Spending Trend",
              insight.spendingTrend,
            ),

            const SizedBox(height: 18),

            _item(
              Icons.lightbulb,
              Colors.deepPurple,
              "Recommendation",
              insight.recommendation,
            ),

            const Divider(height: 35),

            Row(
  children: [

    const Icon(
      Icons.update,
      size: 18,
      color: Colors.grey,
    ),

    const SizedBox(width: 8),

    Text(
      updatedText,
      style: const TextStyle(
        color: Colors.grey,
      ),
    ),

  ],
),
          ],
        ),
      ),
    );
  }

  Widget _item(
    IconData icon,
    Color color,
    String title,
    String value,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        CircleAvatar(
          radius: 18,
          backgroundColor: color.withOpacity(.12),
          child: Icon(
            icon,
            color: color,
            size: 20,
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

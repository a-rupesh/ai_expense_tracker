<<<<<<< HEAD
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CategoryPieChart extends StatelessWidget {
  final Map<String, double> data;

  const CategoryPieChart({
    super.key,
    required this.data,
  });

  static const List<Color> colors = [
    Colors.orange,
    Colors.green,
    Colors.blue,
    Colors.red,
    Colors.purple,
    Colors.teal,
    Colors.brown,
    Colors.indigo,
  ];

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(
        child: Text(
          "No expense data available",
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    final total = data.values.fold<double>(
      0,
      (sum, value) => sum + value,
    );

    int index = 0;

    return SizedBox(
      height: 300,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 3,
              centerSpaceRadius: 55,
              borderData: FlBorderData(show: false),

              sections: data.entries.map((entry) {
                final percentage = (entry.value / total) * 100;

                final section = PieChartSectionData(
                  color: colors[index % colors.length],
                  value: entry.value,
                  radius: 80,
                  title:
                      "${entry.key}\n${percentage.toStringAsFixed(0)}%",
                  titleStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                );

                index++;

                return section;
              }).toList(),
            ),
          ),

          /// Center Text
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Total",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              Text(
                "₹${total.toStringAsFixed(0)}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
=======
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CategoryPieChart extends StatelessWidget {
  final Map<String, double> data;

  const CategoryPieChart({
    super.key,
    required this.data,
  });

  static const List<Color> colors = [
    Colors.orange,
    Colors.green,
    Colors.blue,
    Colors.red,
    Colors.purple,
    Colors.teal,
    Colors.brown,
    Colors.indigo,
  ];

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(
        child: Text(
          "No expense data available",
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    final total = data.values.fold<double>(
      0,
      (sum, value) => sum + value,
    );

    int index = 0;

    return SizedBox(
      height: 300,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 3,
              centerSpaceRadius: 55,
              borderData: FlBorderData(show: false),

              sections: data.entries.map((entry) {
                final percentage = (entry.value / total) * 100;

                final section = PieChartSectionData(
                  color: colors[index % colors.length],
                  value: entry.value,
                  radius: 80,
                  title:
                      "${entry.key}\n${percentage.toStringAsFixed(0)}%",
                  titleStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                );

                index++;

                return section;
              }).toList(),
            ),
          ),

          /// Center Text
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Total",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              Text(
                "₹${total.toStringAsFixed(0)}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
>>>>>>> 656d780915e823b4356a161e248a42e061f060ed
}
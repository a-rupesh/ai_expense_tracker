import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeeklyBarChart extends StatelessWidget {
  final Map<String, double> weeklyData;

  const WeeklyBarChart({super.key, required this.weeklyData});

  @override
  Widget build(BuildContext context) {
    final days = weeklyData.keys.toList();

    return SizedBox(
      height: 260,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,

          borderData: FlBorderData(show: false),

          gridData: const FlGridData(show: false),

          titlesData: FlTitlesData(
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),

            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),

            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),

            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,

                getTitlesWidget: (value, meta) {
                  return Text(days[value.toInt()]);
                },
              ),
            ),
          ),

          barGroups: List.generate(days.length, (index) {
            return BarChartGroupData(
              x: index,

              barRods: [
                BarChartRodData(
                  toY: weeklyData[days[index]]!,

                  width: 20,

                  borderRadius: BorderRadius.circular(6),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

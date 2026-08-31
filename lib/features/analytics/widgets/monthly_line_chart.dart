import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MonthlyLineChart extends StatelessWidget {
  final Map<String, double> monthlyData;

  const MonthlyLineChart({
    super.key,
    required this.monthlyData,
  });

  @override
  Widget build(BuildContext context) {
    final months = monthlyData.keys.toList();

    final spots = List.generate(
      months.length,
      (index) => FlSpot(
        index.toDouble(),
        monthlyData[months[index]]!,
      ),
    );

    return SizedBox(
      height: 280,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: 11,
          minY: 0,

          borderData: FlBorderData(show: false),

          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 100,
          ),

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
                reservedSize: 28,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() >= months.length) {
                    return const SizedBox();
                  }

                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      months[value.toInt()],
                      style: const TextStyle(fontSize: 11),
                    ),
                  );
                },
              ),
            ),
          ),

          lineBarsData: [
            LineChartBarData(
              spots: spots,

              isCurved: false,

              color: Colors.deepPurple,

              barWidth: 4,

              isStrokeCapRound: true,

              dotData: const FlDotData(
                show: true,
              ),

              belowBarData: BarAreaData(
                show: true,
                color: Colors.deepPurple.withOpacity(0.15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

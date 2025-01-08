import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsMenuScreen extends StatelessWidget {
  final int totalItems;
  final int totalPoints;
  final double totalRevenue;

  const StatisticsMenuScreen({
    Key? key,
    required this.totalItems,
    required this.totalPoints,
    required this.totalRevenue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Text(
              'Menu Statistics Overview',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: totalItems.toDouble(),
                      color: Colors.blue,
                      title:
                          '${((totalItems / (totalItems + totalPoints + totalRevenue)) * 100).toStringAsFixed(1)}%',
                      radius: 80,
                      titleStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      value: totalPoints.toDouble(),
                      color: Colors.green,
                      title:
                          '${((totalPoints / (totalItems + totalPoints + totalRevenue)) * 100).toStringAsFixed(1)}%',
                      radius: 80,
                      titleStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      value: totalRevenue,
                      color: Colors.red,
                      title:
                          '${((totalRevenue / (totalItems + totalPoints + totalRevenue)) * 100).toStringAsFixed(1)}%',
                      radius: 80,
                      titleStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                  sectionsSpace: 2,
                  centerSpaceRadius: 50,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLegend(
                  color: Colors.blue,
                  title: 'Items',
                  value: totalItems.toString(),
                ),
                _buildLegend(
                  color: Colors.green,
                  title: 'Points',
                  value: totalPoints.toString(),
                ),
                _buildLegend(
                  color: Colors.red,
                  title: 'Revenue',
                  value: '\$${totalRevenue.toStringAsFixed(2)}',
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend(
      {required Color color, required String title, required String value}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

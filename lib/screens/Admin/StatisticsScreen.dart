import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsScreen extends StatelessWidget {
  final int userCount;
  final int adminCount;

  const StatisticsScreen({
    Key? key,
    required this.userCount,
    required this.adminCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int totalCount = userCount + adminCount;

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
              'User and Admin Distribution',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      color: Colors.orangeAccent,
                      value: userCount.toDouble(),
                      title:
                          '${((userCount / totalCount) * 100).toStringAsFixed(1)}%',
                      radius: 80,
                      titleStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.blueAccent,
                      value: adminCount.toDouble(),
                      title:
                          '${((adminCount / totalCount) * 100).toStringAsFixed(1)}%',
                      radius: 80,
                      titleStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                  sectionsSpace: 2,
                  centerSpaceRadius: 60,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLegend(
                  color: Colors.orangeAccent,
                  title: 'Users: $userCount',
                ),
                _buildLegend(
                  color: Colors.blueAccent,
                  title: 'Admins: $adminCount',
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend({required Color color, required String title}) {
    return Row(
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
        Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

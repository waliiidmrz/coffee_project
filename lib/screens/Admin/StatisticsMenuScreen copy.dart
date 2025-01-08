import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Product {
  final String name;
  final int bought;
  final int ordered;

  Product({
    required this.name,
    required this.bought,
    required this.ordered,
  });
}

class StatisticsMenuScreen extends StatelessWidget {
  final List<Product> products;

  const StatisticsMenuScreen({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int totalBought = products.fold(0, (sum, item) => sum + item.bought);
    int totalOrdered = products.fold(0, (sum, item) => sum + item.ordered);

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
              'Product Statistics Overview',
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
                  sections: products.map((product) {
                    double total = (totalBought + totalOrdered) as double;
                    return PieChartSectionData(
                      value: (product.bought + product.ordered).toDouble(),
                      color: Colors.primaries[
                          products.indexOf(product) % Colors.primaries.length],
                      title:
                          '${((product.bought + product.ordered) / total * 100).toStringAsFixed(1)}%',
                      radius: 80,
                      titleStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  }).toList(),
                  sectionsSpace: 2,
                  centerSpaceRadius: 50,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return _buildLegend(
                    color: Colors.primaries[index % Colors.primaries.length],
                    title: product.name,
                    bought: product.bought.toString(),
                    ordered: product.ordered.toString(),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend({
    required Color color,
    required String title,
    required String bought,
    required String ordered,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
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
                'Bought: $bought',
                style: TextStyle(
                  fontSize: 14,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Ordered: $ordered',
                style: TextStyle(
                  fontSize: 14,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: StatisticsMenuScreen(
      products: [
        Product(name: 'Espresso', bought: 150, ordered: 200),
        Product(name: 'Latte', bought: 100, ordered: 150),
        Product(name: 'Cappuccino', bought: 80, ordered: 120),
        Product(name: 'Mocha', bought: 60, ordered: 90),
        Product(name: 'Americano', bought: 50, ordered: 70),
      ],
    ),
  ));
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // For date formatting

class OrderHistoryScreen extends StatefulWidget {
  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  final List<Map<String, dynamic>> orderHistory = [
    {
      "date": "12 Dec 2024",
      "total": 24.53,
      "items": ["Cappuccino", "Latte"],
      "status": "Completed",
      "address": "123 Coffee St, Latte City",
      "payment": "Credit Card"
    },
    {
      "date": "10 Dec 2024",
      "total": 18.20,
      "items": ["Americano", "Mocha"],
      "status": "Pending",
      "address": "456 Brew Ave, Espresso Town",
      "payment": "Cash"
    },
    {
      "date": "05 Dec 2024",
      "total": 35.10,
      "items": ["Espresso", "Flat White"],
      "status": "Canceled",
      "address": "789 Roast Blvd, Cappuccino City",
      "payment": "Gift Card"
    },
  ];

  DateTime? startDate;
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    double totalSpending =
        orderHistory.fold(0, (sum, order) => sum + order['total']);
    double averageSpending = totalSpending / orderHistory.length;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Order History',
          style: GoogleFonts.sora(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Color(0xFFC52127)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section Header with Date Range Filter
                _buildDateRangeFilter(context),
                const SizedBox(height: 16),
                // Order History Overview
                _buildOrderHistoryOverview(totalSpending, averageSpending),
                const SizedBox(height: 20),
                // Order List
                ...orderHistory.map((order) => _buildOrderCard(order)).toList(),
              ],
            ),
          ),
          // Floating Action Button
          Positioned(
            bottom: 0,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                _showFilterOptions(context);
              },
              backgroundColor: const Color(0xFFC52127),
              child: const Icon(Icons.filter_list, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateRangeFilter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Date Range Title and Chips
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Filter by Date',
                style: GoogleFonts.sora(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFC52127),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  // Start Date Chip
                  GestureDetector(
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: startDate ?? DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (picked != null) {
                        setState(() => startDate = picked);
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: startDate != null
                            ? const Color(0xFFC52127)
                            : const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: startDate != null
                            ? [
                                BoxShadow(
                                  color: Colors.redAccent.withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : [],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.date_range,
                              size: 20, color: Colors.grey[700]),
                          const SizedBox(width: 6),
                          Text(
                            startDate != null
                                ? DateFormat('dd MMM yyyy').format(startDate!)
                                : 'Start Date',
                            style: GoogleFonts.sora(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: startDate != null
                                  ? Colors.white
                                  : Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // End Date Chip
                  GestureDetector(
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: endDate ?? DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (picked != null) {
                        setState(() => endDate = picked);
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: endDate != null
                            ? const Color(0xFFC52127)
                            : const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: endDate != null
                            ? [
                                BoxShadow(
                                  color: Colors.redAccent.withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : [],
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.date_range,
                              size: 20, color: Colors.grey[700]),
                          const SizedBox(width: 6),
                          Text(
                            endDate != null
                                ? DateFormat('dd MMM yyyy').format(endDate!)
                                : 'End Date',
                            style: GoogleFonts.sora(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: endDate != null
                                  ? Colors.white
                                  : Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        label,
        style: GoogleFonts.sora(fontSize: 14, color: Colors.grey[700]),
      ),
    );
  }

  Widget _buildOrderHistoryOverview(
      double totalSpending, double averageSpending) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order Overview',
                style: GoogleFonts.sora(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildOverviewStat('Total Orders', '${orderHistory.length}'),
                _buildOverviewStat(
                    'Total Spent', '\$${totalSpending.toStringAsFixed(2)}'),
                _buildOverviewStat(
                    'Avg Spending', '\$${averageSpending.toStringAsFixed(2)}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.sora(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFC52127)),
        ),
        Text(
          label,
          style: GoogleFonts.sora(fontSize: 14, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(order['date'],
                    style: GoogleFonts.sora(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                Text('Status: ${order['status']}',
                    style: GoogleFonts.sora(
                        fontSize: 14,
                        color: order['status'] == 'Completed'
                            ? Colors.green
                            : (order['status'] == 'Pending'
                                ? Colors.orange
                                : Colors.red))),
              ],
            ),
            Text('\$${order['total']}',
                style: GoogleFonts.sora(
                    fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Items: ${order['items'].join(', ')}',
                    style: GoogleFonts.sora(
                        fontSize: 14, color: Colors.grey[600])),
                const SizedBox(height: 8),
                Text('Address: ${order['address']}',
                    style: GoogleFonts.sora(
                        fontSize: 14, color: Colors.grey[600])),
                const SizedBox(height: 8),
                Text('Payment Method: ${order['payment']}',
                    style: GoogleFonts.sora(
                        fontSize: 14, color: Colors.grey[600])),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterOptions(BuildContext context) {
    // Example for future filter implementation
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Filter Options',
                style: GoogleFonts.sora(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.check),
              title: const Text('Completed Orders'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.pending),
              title: const Text('Pending Orders'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.cancel),
              title: const Text('Canceled Orders'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

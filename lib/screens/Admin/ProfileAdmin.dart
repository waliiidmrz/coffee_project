import 'package:flutter/material.dart';

class AdminProfileScreen extends StatelessWidget {
  final Map<String, dynamic> adminDetails = {
    'name': 'Admin Name',
    'email': 'admin@example.com',
    'role': 'Administrator',
    'profilePicture': 'https://via.placeholder.com/100',
  };

  final List<Map<String, String>> stats = [
    {'label': 'Users', 'value': '1200'},
    {'label': 'Orders', 'value': '3500'},
    {'label': 'Revenue', 'value': '\$50,000'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: const Text(
          'Admin Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings'); // Navigate to settings
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushNamed(context, '/login'); // Logout and go to login
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Header
            _buildProfileHeader(context),
            const SizedBox(height: 20),
            // Stats Section
            _buildStatsSection(),
            const SizedBox(height: 20),
            // Actions Section
            _buildActionsSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(adminDetails['profilePicture']),
        ),
        const SizedBox(height: 12),
        Text(
          adminDetails['name'],
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          adminDetails['email'],
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          adminDetails['role'],
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Navigate to Edit Profile
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFC52127),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: const Text(
            'Edit Profile',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsSection() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Admin Statistics',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: stats.map((stat) {
                return Column(
                  children: [
                    Text(
                      stat['value']!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      stat['label']!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionsSection(BuildContext context) {
    return Column(
      children: [
        _buildActionCard(
          context,
          title: 'Manage Users',
          icon: Icons.people,
          onTap: () {
            // Navigate to Manage Users
          },
        ),
        const SizedBox(height: 10),
        _buildActionCard(
          context,
          title: 'View Reports',
          icon: Icons.bar_chart,
          onTap: () {
            // Navigate to View Reports
          },
        ),
        const SizedBox(height: 10),
        _buildActionCard(
          context,
          title: 'Settings',
          icon: Icons.settings,
          onTap: () {
            // Navigate to Settings
          },
        ),
      ],
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xFFC52127),
                child: Icon(icon, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

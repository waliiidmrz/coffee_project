import 'package:flutter/material.dart';

class User {
  final String name;
  final String lastname;
  final String email;
  final String phoneNumber;
  final String profileImage;
  final DateTime? birthDate;

  User({
    required this.name,
    required this.lastname,
    required this.email,
    required this.phoneNumber,
    required this.profileImage,
    this.birthDate,
  });
}

class ProfileAdminScreen extends StatelessWidget {
  final User user;

  const ProfileAdminScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture
            Center(
              child: CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(user.profileImage),
              ),
            ),
            const SizedBox(height: 16),
            // Name
            Text(
              '${user.name} ${user.lastname}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            // Email
            Text(
              user.email,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            // Details Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const Divider(),
                    // Phone
                    _buildDetailRow(
                      icon: Icons.phone,
                      label: 'Phone',
                      value: user.phoneNumber,
                    ),
                    const SizedBox(height: 12),
                    // Birthday
                    if (user.birthDate != null)
                      _buildDetailRow(
                        icon: Icons.cake,
                        label: 'Birthday',
                        value:
                            '${user.birthDate!.toLocal().toString().split(' ')[0]}',
                      ),
                    const SizedBox(height: 12),
                    // Email
                    _buildDetailRow(
                      icon: Icons.email,
                      label: 'Email',
                      value: user.email,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Logout Button
            ElevatedButton.icon(
              onPressed: () {
                // Handle logout logic
              },
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
      {required IconData icon, required String label, required String value}) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue, size: 28),
        const SizedBox(width: 16),
        Text(
          '$label:',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

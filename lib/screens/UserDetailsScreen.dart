import 'package:coffee_project/screens/admin_user_list_screen.dart';
import 'package:flutter/material.dart';

class UserDetailsScreen extends StatelessWidget {
  final User user;
  final VoidCallback onDelete;
  final VoidCallback onToggleBlock;

  const UserDetailsScreen({
    Key? key,
    required this.user,
    required this.onDelete,
    required this.onToggleBlock,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User Details',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // User Profile Picture
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blueAccent, width: 3),
              ),
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(user.profileImage),
              ),
            ),
            const SizedBox(height: 16),

            // User Name
            Text(
              '${user.name} ${user.lastname}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            // Email and Phone
            Text(
              'Email: ${user.email}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              'Phone: ${user.phoneNumber}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 8),

            // Birthday
            if (user.birthDate != null)
              Text(
                'Birthday: ${user.birthDate!.toLocal().toString().split(' ')[0]}',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),

            const SizedBox(height: 16),

            // Points and Gift Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Points',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${user.isBlocked ? 0 : 150}', // Example value
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const VerticalDivider(
                      color: Colors.grey,
                      thickness: 1,
                      width: 20,
                    ),
                    Column(
                      children: [
                        const Text(
                          'Gift Card',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user.isBlocked ? 'None' : '\$25', // Example value
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Location (Placeholder for now)
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.location_on, color: Colors.blueAccent),
                SizedBox(width: 8),
                Text(
                  'San Francisco, CA',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Block/Unblock Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: user.isBlocked ? Colors.red : Colors.green,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    onToggleBlock();
                    Navigator.pop(context);
                  },
                  icon: Icon(user.isBlocked ? Icons.lock_open : Icons.block),
                  label: Text(user.isBlocked ? 'Unblock' : 'Block'),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    onDelete();
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

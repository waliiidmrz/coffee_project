import 'package:flutter/material.dart';

class User {
  final String name;
  final String email;
  final String phoneNumber;
  final String profileImage;
  bool isBlocked;
  int points;
  double giftCardBalance;

  User({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.profileImage,
    this.isBlocked = false,
    this.points = 0,
    this.giftCardBalance = 0.0,
  });
}

class AdminUserListScreen extends StatefulWidget {
  const AdminUserListScreen({Key? key}) : super(key: key);

  @override
  _AdminUserListScreenState createState() => _AdminUserListScreenState();
}

class _AdminUserListScreenState extends State<AdminUserListScreen> {
  final List<User> users = [
    User(
      name: 'John Doe',
      email: 'john.doe@example.com',
      phoneNumber: '+1 234 567 890',
      profileImage: 'https://via.placeholder.com/150',
      points: 120,
      giftCardBalance: 50.0,
    ),
    User(
      name: 'Jane Smith',
      email: 'jane.smith@example.com',
      phoneNumber: '+1 987 654 321',
      profileImage: 'https://via.placeholder.com/150',
      isBlocked: true,
      points: 200,
      giftCardBalance: 30.0,
    ),
  ];

  void _showUserDetails(BuildContext context, User user) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Details for ${user.name}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(user.profileImage),
              ),
              const SizedBox(height: 16),
              Text('Email: ${user.email}'),
              Text('Phone: ${user.phoneNumber}'),
              Text('Points: ${user.points}'),
              Text(
                  'Gift Card Balance: \$${user.giftCardBalance.toStringAsFixed(2)}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _toggleBlockUser(User user) {
    setState(() {
      user.isBlocked = !user.isBlocked;
    });
  }

  void _deleteUser(User user) {
    setState(() {
      users.remove(user);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        backgroundColor: const Color(0xFFC52127),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            color: user.isBlocked ? Colors.grey[300] : Colors.white,
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(user.profileImage),
              ),
              title: Text(
                user.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      user.isBlocked ? Icons.lock_open : Icons.lock,
                      color: user.isBlocked ? Colors.green : Colors.red,
                    ),
                    onPressed: () => _toggleBlockUser(user),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteUser(user),
                  ),
                  IconButton(
                    icon: const Icon(Icons.info, color: Colors.blue),
                    onPressed: () => _showUserDetails(context, user),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

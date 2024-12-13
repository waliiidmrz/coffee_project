import 'package:flutter/material.dart';

class User {
  final String name;
  final String email;
  final String phoneNumber;
  final String profileImage;
  final String role; // "user" or "admin"
  bool isBlocked;
  int points;
  double giftCardBalance;
  DateTime? birthDate;

  User({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.profileImage,
    required this.role,
    this.isBlocked = false,
    this.points = 0,
    this.giftCardBalance = 0.0,
    this.birthDate,
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
      role: 'user',
      points: 120,
      giftCardBalance: 50.0,
      birthDate: DateTime(1990, 5, 15),
    ),
    User(
      name: 'Jane Smith',
      email: 'jane.smith@example.com',
      phoneNumber: '+1 987 654 321',
      profileImage: 'https://via.placeholder.com/150',
      role: 'user',
      isBlocked: true,
      points: 200,
      giftCardBalance: 30.0,
      birthDate: DateTime(1992, 8, 22),
    ),
    User(
      name: 'Admin User',
      email: 'admin@example.com',
      phoneNumber: '+1 555 123 456',
      profileImage: 'https://via.placeholder.com/150',
      role: 'admin',
      birthDate: DateTime(1985, 3, 10),
    ),
  ];

  String filterRole = 'all'; // Filter: all, user, admin

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
              if (user.birthDate != null)
                Text(
                    'Birthday: ${user.birthDate!.toLocal().toString().split(' ')[0]}'),
              if (user.role == 'user') Text('Points: ${user.points}'),
              if (user.role == 'user')
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

  void _addAdminUser() {
    showDialog(
      context: context,
      builder: (context) {
        final nameController = TextEditingController();
        final emailController = TextEditingController();
        final phoneController = TextEditingController();
        DateTime? birthDate;

        return AlertDialog(
          title: const Text('Add New Admin'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (selectedDate != null) {
                    birthDate = selectedDate;
                  }
                },
                child: const Text('Select Birthdate'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  users.add(
                    User(
                      name: nameController.text,
                      email: emailController.text,
                      phoneNumber: phoneController.text,
                      profileImage: 'https://via.placeholder.com/150',
                      role: 'admin',
                      birthDate: birthDate,
                    ),
                  );
                });
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredUsers = filterRole == 'all'
        ? users
        : users.where((user) => user.role == filterRole).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        backgroundColor: const Color(0xFFC52127),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.group),
                        title: const Text('All Users'),
                        onTap: () {
                          setState(() {
                            filterRole = 'all';
                          });
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.person),
                        title: const Text('Users'),
                        onTap: () {
                          setState(() {
                            filterRole = 'user';
                          });
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.admin_panel_settings),
                        title: const Text('Admins'),
                        onTap: () {
                          setState(() {
                            filterRole = 'admin';
                          });
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
            },
            tooltip: 'Filter Users',
          ),
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: _addAdminUser,
            tooltip: 'Add Admin',
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: filteredUsers.length,
        itemBuilder: (context, index) {
          final user = filteredUsers[index];
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
              subtitle: Text(user.role == 'admin' ? 'Admin' : 'User'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (user.role == 'user')
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

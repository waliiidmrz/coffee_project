import 'package:coffee_project/widgets/UserCard.dart';
import 'package:flutter/material.dart';
import 'StatisticsScreen.dart';

class User {
  final String name;
  final String lastname;
  final String email;
  final String phoneNumber;
  final String profileImage;
  final String role; // "user" or "admin"
  bool isBlocked;
  DateTime? birthDate;

  User({
    required this.name,
    required this.lastname,
    required this.email,
    required this.phoneNumber,
    required this.profileImage,
    required this.role,
    this.isBlocked = false,
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
      name: 'John',
      lastname: 'Doe',
      email: 'john.doe@example.com',
      phoneNumber: '+1 234 567 890',
      profileImage: 'https://via.placeholder.com/150',
      role: 'user',
      isBlocked: false,
      birthDate: DateTime(1990, 5, 15),
    ),
    User(
      name: 'Jane',
      lastname: 'Smith',
      email: 'jane.smith@example.com',
      phoneNumber: '+1 987 654 321',
      profileImage: 'https://via.placeholder.com/150',
      role: 'user',
      isBlocked: true,
      birthDate: DateTime(1992, 8, 22),
    ),
    User(
      name: 'Admin',
      lastname: 'User',
      email: 'admin@example.com',
      phoneNumber: '+1 555 123 456',
      profileImage: 'https://via.placeholder.com/150',
      role: 'admin',
      isBlocked: false,
      birthDate: DateTime(1985, 3, 10),
    ),
  ];

  String filterRole = 'all';

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

  void _addUserDialog(BuildContext context, String role) {
    final nameController = TextEditingController();
    final lastnameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    DateTime? birthDate;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor:
                    role == 'admin' ? Colors.blueAccent : Colors.orangeAccent,
                child: Icon(
                  role == 'admin'
                      ? Icons.admin_panel_settings
                      : Icons.person_add,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Add ${role == 'admin' ? 'Admin' : 'User'}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField(
                  controller: nameController,
                  label: 'First Name',
                  icon: Icons.person,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: lastnameController,
                  label: 'Last Name',
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: emailController,
                  label: 'Email Address',
                  icon: Icons.email,
                  inputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: phoneController,
                  label: 'Phone Number',
                  icon: Icons.phone,
                  inputType: TextInputType.phone,
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
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
                  icon: const Icon(Icons.calendar_today, color: Colors.white),
                  label: Text(
                    birthDate == null
                        ? 'Select Birthdate'
                        : 'Selected: ${birthDate!.toLocal().toString().split(' ')[0]}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.redAccent,
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 16),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                if (nameController.text.isEmpty ||
                    lastnameController.text.isEmpty ||
                    emailController.text.isEmpty ||
                    phoneController.text.isEmpty ||
                    birthDate == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill in all fields.'),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                  return;
                }

                setState(() {
                  users.add(
                    User(
                      name: nameController.text,
                      lastname: lastnameController.text,
                      email: emailController.text,
                      phoneNumber: phoneController.text,
                      profileImage: 'https://via.placeholder.com/150',
                      role: role,
                      birthDate: birthDate,
                    ),
                  );
                });

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${role == 'admin' ? 'Admin' : 'User'} added successfully!',
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text(
                'Add',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType inputType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 14),
        prefixIcon: Icon(icon, color: Colors.deepPurpleAccent),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.deepPurpleAccent),
        ),
      ),
    );
  }

  void _showUserDetails(BuildContext context, User user) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Details for ${user.name} ${user.lastname}'),
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

  void _navigateToStatistics() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StatisticsScreen(
          userCount: users.where((user) => user.role == 'user').length,
          adminCount: users.where((user) => user.role == 'admin').length,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredUsers = filterRole == 'all'
        ? users
        : users.where((user) => user.role == filterRole).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: const Color.fromARGB(255, 251, 250, 250),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                filterRole = value;
              });
            },
            icon: const Icon(Icons.filter_alt),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'all',
                child: Text('All Users'),
              ),
              const PopupMenuItem(
                value: 'user',
                child: Text('Users'),
              ),
              const PopupMenuItem(
                value: 'admin',
                child: Text('Admins'),
              ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: filteredUsers.length,
        itemBuilder: (context, index) {
          final user = filteredUsers[index];
          return UserCard(
            name: user.name,
            lastname: user.lastname,
            email: user.email,
            profileImage: user.profileImage,
            role: user.role,
            isBlocked: user.isBlocked,
            onToggleBlock: () => _toggleBlockUser(user),
            onDelete: () => _deleteUser(user),
            onViewDetails: () => _showUserDetails(context, user),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Add User Button on the Left
          Padding(
            padding: const EdgeInsets.only(
                left: 32), // Adjust spacing from the screen edge
            child: FloatingActionButton(
              heroTag: 'statistics',
              onPressed: _navigateToStatistics,
              backgroundColor: Colors.blue,
              child: const Icon(Icons.bar_chart),
            ),
          ),
          // Statistics Button on the Right
          Padding(
            padding: const EdgeInsets.only(
                right: 32), // Adjust spacing from the screen edge
            child: FloatingActionButton(
              heroTag: 'add_user',
              onPressed: () => _addUserDialog(context, 'admin'), // Or 'user'
              backgroundColor: Colors.green,
              child: const Icon(Icons.person_add),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:BISOU/screens/StatisticsScreen.dart';
import 'package:BISOU/screens/UserDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  final ImagePicker _picker = ImagePicker();
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
      role: 'admin',
      isBlocked: true,
      birthDate: DateTime(1992, 8, 22),
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
        prefixIcon: Icon(icon, color: Colors.red),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
      ),
    );
  }

  void _addUserDialog(BuildContext context, String role) {
    final nameController = TextEditingController();
    final lastnameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    DateTime? birthDate;
    String? imagePath;

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
                    role == 'admin' ? Colors.red : Colors.orangeAccent,
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
                    backgroundColor: const Color.fromARGB(255, 244, 237, 237),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 20),
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
                  icon: const Icon(Icons.calendar_today, color: Colors.red),
                  label: Text(
                    birthDate == null
                        ? 'Select Birthdate'
                        : 'Selected: ${birthDate!.toLocal().toString().split(' ')[0]}',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    final pickedFile =
                        await _picker.pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      setState(() {
                        imagePath = pickedFile.path;
                      });
                    }
                  },
                  child: const Text('Upload Image'),
                ),
                if (imagePath != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Image.file(
                      File(imagePath!),
                      height: 100,
                      fit: BoxFit.cover,
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
                backgroundColor: const Color.fromARGB(255, 195, 63, 53),
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
        title: const Text(
          'User Management',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Filter Buttons
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildFilterButton(
                  label: 'All',
                  isSelected: filterRole == 'all',
                  onPressed: () {
                    setState(() {
                      filterRole = 'all';
                    });
                  },
                ),
                _buildFilterButton(
                  label: 'Admins',
                  isSelected: filterRole == 'admin',
                  onPressed: () {
                    setState(() {
                      filterRole = 'admin';
                    });
                  },
                ),
                _buildFilterButton(
                  label: 'Users',
                  isSelected: filterRole == 'user',
                  onPressed: () {
                    setState(() {
                      filterRole = 'user';
                    });
                  },
                ),
              ],
            ),
          ),
          // User List
          Expanded(
            child: filteredUsers.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredUsers.length,
                    itemBuilder: (context, index) {
                      final user = filteredUsers[index];
                      return _buildUserCard(user);
                    },
                  )
                : const Center(
                    child: Text(
                      'No users found.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ),
          ),
        ],
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
              backgroundColor: Colors.red,
              child: const Icon(Icons.person_add),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton({
    required String label,
    required bool isSelected,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.red : Colors.grey[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildUserCard(User user) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserDetailsScreen(
            user: user,
            onDelete: () => _deleteUser(user),
            onToggleBlock: () => _toggleBlockUser(user),
          ),
        ),
      ),
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(user.profileImage),
          ),
          title: Text(
            '${user.name} ${user.lastname}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Email: ${user.email}'),
              Text('Role: ${user.role}'),
              Text(
                user.isBlocked ? 'Status: Blocked' : 'Status: Active',
                style: TextStyle(
                  color: user.isBlocked ? Colors.red : Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

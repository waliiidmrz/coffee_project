import 'package:BISOU/screens/admin_user_list_screen.dart';
import 'package:flutter/material.dart';
import 'edit_profile_admin.dart';
import 'edit_password_admin.dart';

class ProfileAdminScreen extends StatefulWidget {
  const ProfileAdminScreen({Key? key, required User user}) : super(key: key);

  @override
  _ProfileAdminScreenState createState() => _ProfileAdminScreenState();
}

class _ProfileAdminScreenState extends State<ProfileAdminScreen> {
  String _name = "John";
  String _lastname = "Doe";
  String _email = "john.doe@example.com";
  String _phoneNumber = "+1 234 567 890";
  String _profileImageUrl =
      "https://via.placeholder.com/150"; // Placeholder profile image
  String? _birthDate = "1990-05-15";

  Future<void> _navigateToEditProfile() async {
    final updatedData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileAdminScreen(
          name: _name,
          lastname: _lastname,
          phoneNumber: _phoneNumber,
          birthDate: _birthDate,
          profileImageUrl: _profileImageUrl,
        ),
      ),
    );

    if (updatedData != null) {
      setState(() {
        _name = updatedData['name'] ?? _name;
        _lastname = updatedData['lastname'] ?? _lastname;
        _phoneNumber = updatedData['phoneNumber'] ?? _phoneNumber;
        _birthDate = updatedData['birthDate'] ?? _birthDate;
        _profileImageUrl = updatedData['profileImageUrl'] ?? _profileImageUrl;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
    }
  }

  Future<void> _navigateToChangePassword() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EditPasswordScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: _navigateToEditProfile,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Picture
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(_profileImageUrl),
                  ),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.red,
                    child: IconButton(
                      icon: const Icon(Icons.camera_alt, color: Colors.white),
                      onPressed: _navigateToEditProfile,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Name and Email
            Text(
              '$_name $_lastname',
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _email,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),

            // Information Section
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildInfoRow(Icons.phone, 'Phone Number', _phoneNumber),
                    const Divider(),
                    _buildInfoRow(
                        Icons.cake, 'Birthdate', _birthDate ?? 'Not provided'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Change Password Button
            ElevatedButton.icon(
              onPressed: _navigateToChangePassword,
              icon: const Icon(Icons.lock),
              label: const Text('Change Password'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.blueAccent.withOpacity(0.1),
          child: Icon(icon, color: Colors.red),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

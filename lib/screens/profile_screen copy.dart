import 'package:BISOU/screens/admin_menu_screen.dart';
import 'package:BISOU/screens/admin_order_management_screen.dart';
import 'package:BISOU/screens/admin_user_list_screen.dart';
import 'package:BISOU/screens/edit_profile_screen.dart';
import 'package:BISOU/screens/rewards_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileAdminScreen extends StatelessWidget {
  final Map<String, dynamic> user = {
    'name': 'Jane Cooper',
    'email': 'jane.cooper@example.com',
    'membershipPoints': 450,
    'membershipStatus': 'Gold Member',
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
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          'Profile',
          style: GoogleFonts.sora(
            color: const Color.fromARGB(255, 0, 0, 0),
            fontSize: 24,
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
            // Profile Header Section
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Background Image
                Container(
                  width: double.infinity,
                  height: 200, // Set a height matching your design
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/whitebg.avif'), // Background image
                      fit:
                          BoxFit.cover, // Ensure the image covers the container
                    ),
                    borderRadius: BorderRadius.all(
                        Radius.circular(20)), // Add rounded corners
                  ),
                ),
                // Gradient and Content Overlay
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: const Color.fromARGB(255, 198, 195, 195)),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 255, 62, 49)
                              .withOpacity(0.1),
                          // Shadow color with opacity
                          blurRadius: 8, // Blur intensity
                          offset: const Offset(0, 4), // Shadow position
                        ),
                      ]),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 48,
                          backgroundImage:
                              AssetImage('assets/images/userimage.jpeg'),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        user['name'],
                        style: GoogleFonts.sora(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        user['email'],
                        style: GoogleFonts.sora(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromARGB(255, 56, 55, 55)
                              .withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage()),
                          );
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 20, // Icon size
                        ),
                        label: Text(
                          'Edit Profile',
                          style: GoogleFonts.sora(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFFC52127), // Button color
                          shadowColor: const Color.fromARGB(255, 0, 0, 0)
                              .withOpacity(0.9), // Shadow color
                          elevation: 15, // Elevation for a slight 3D effect
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(16), // Rounded corners
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Floating Points Badge
                Positioned(
                  right: 5,
                  top: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  // Background Image
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/whitebg.avif', // Replace with your image path
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Transparent Overlay (optional for better contrast)
                  Positioned.fill(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: const Color.fromARGB(255, 198, 195, 195)),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 255, 62, 49)
                                  .withOpacity(0.1),
                              // Shadow color with opacity
                              blurRadius: 8, // Blur intensity
                              offset: const Offset(0, 4), // Shadow position
                            ),
                          ]),
                    ),
                  ),
                  // Card Content
                  Container(
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
                ],
              ),
            ),
            const SizedBox(
              height: 35,
            ),

            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  // Background Image
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/whitebg.avif', // Replace with your image path
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Transparent Overlay (optional for better contrast)
                  Positioned.fill(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: const Color.fromARGB(255, 198, 195, 195)),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 255, 62, 49)
                                  .withOpacity(0.1),
                              // Shadow color with opacity
                              blurRadius: 8, // Blur intensity
                              offset: const Offset(0, 4), // Shadow position
                            ),
                          ]),
                    ),
                  ),
                  // Card Content
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AdminUserListScreen()),
                                );
                              },
                              child: buildStatItem(
                                  'Manage Users', '1200', Icons.people),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AdminMenuScreen()),
                                );
                              },
                              child: buildStatItem(
                                  'View Reports', '50', Icons.bar_chart),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20), // Space between rows
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AdminOrderManagementScreen()),
                                );
                              },
                              child: buildStatItem(
                                  'Manage Orders', '3500', Icons.shopping_cart),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 35,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF54E4E), Color(0xFFC52127)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 32, // Increased size for better visibility
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.sora(
            fontSize: 14,
            color: Colors.grey[600], // Softer color for better contrast
          ),
        ),
      ],
    );
  }
}

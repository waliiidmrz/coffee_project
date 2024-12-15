import 'package:BISOU/screens/edit_profile_screen.dart';
import 'package:BISOU/screens/favorites_screen.dart';
import 'package:BISOU/screens/order_history_screen.dart';
import 'package:BISOU/screens/rewards_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  final Map<String, dynamic> user = {
    'name': 'Jane Cooper',
    'email': 'jane.cooper@example.com',
    'membershipPoints': 450,
    'membershipStatus': 'Gold Member',
  };

  final List<Map<String, String>> rewards = [
    {'points': '100', 'reward': '10% discount'},
    {'points': '200', 'reward': '15% discount'},
    {'points': '300', 'reward': '20% discount'},
    {'points': '400', 'reward': '25% discount'},
    {'points': '500', 'reward': '30% discount'},
    {'points': '700', 'reward': '35% discount'},
    {'points': '1000', 'reward': '70% discount (MAX)'},
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
                    child: Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Color(0xFFFFD700),
                          size: 24,
                          shadows: [
                            Shadow(
                                color: Colors.black,
                                offset: Offset(0.1, 0),
                                blurRadius: 3)
                          ],
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${user['membershipPoints']} pts',
                          style: GoogleFonts.sora(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
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
              child: Container(
                height: 200, // Set the height of the card
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    // Background Image
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/images/goldbg.avif', // Path to your background image
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Transparent Overlay
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black
                              .withOpacity(0.3), // Dark overlay for contrast
                        ),
                      ),
                    ),
                    // Membership Title and Icon
                    Positioned(
                      top: 20,
                      left: 20,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.card_membership,
                            color: Colors.white,
                            size: 28,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Membership Status',
                            style: GoogleFonts.sora(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Floating Membership Badge
                    Positioned(
                      top: 20,
                      right: 20,
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/images/goldmember.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    // Points and Progress Bar
                    Positioned(
                      bottom: 70,
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Points: ${user['membershipPoints']} pts',
                            style: GoogleFonts.sora(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Stack(
                            children: [
                              Container(
                                height: 8,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              Container(
                                height: 8,
                                width: (user['membershipPoints'] / 1000) * 200,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Next Reward: 500 pts',
                            style: GoogleFonts.sora(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Rewards Button
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: ElevatedButton(
                        onPressed: () {
                          showRewardsDialog(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.card_giftcard,
                                color: Colors.black),
                            const SizedBox(width: 8),
                            Text(
                              'Rewards',
                              style: GoogleFonts.sora(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderHistoryScreen()),
                            );
                          },
                          child: buildStatItem(
                              'Orders', '150', Icons.shopping_bag),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FavoritesScreen()),
                            );
                          },
                          child:
                              buildStatItem('Favorites', '25', Icons.favorite),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Handle Reviews navigation
                            print('Navigating to Reviews');
                          },
                          child: buildStatItem('Reviews', '40', Icons.star),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showRewardsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return RewardsDialog(
          userPoints: user['membershipPoints'], // Pass user points
        );
      },
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

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditEmailFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Email"),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFFC52127)),
        titleTextStyle: GoogleFonts.sora(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: const Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header Icon with Glow
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF4E9EF5), Color(0xFF2763C5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.4),
                    blurRadius: 30,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Icon(Icons.email, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 24),
            Text(
              "Update Your Email",
              style: GoogleFonts.sora(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2F2D2C),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Enter your new email address and keep your account secure.",
              style: GoogleFonts.sora(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.grey[600],
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // Input Field with Rounded Border
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "New Email",
                labelStyle: GoogleFonts.sora(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
                prefixIcon: const Icon(Icons.email, color: Color(0xFF2763C5)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                filled: true,
                fillColor: const Color(0xFFF8F9FA),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: Color(0xFF2763C5),
                    width: 2,
                  ),
                ),
              ),
              cursorColor: const Color(0xFF2763C5),
            ),
            const SizedBox(height: 40),

            // Save Button with Icon
            ElevatedButton.icon(
              onPressed: () {
                // Handle Save
              },
              icon: const Icon(Icons.save_alt, color: Colors.white),
              label: const Text(
                "Save Changes",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2763C5),
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 10,
                shadowColor: Colors.blueAccent.withOpacity(0.3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

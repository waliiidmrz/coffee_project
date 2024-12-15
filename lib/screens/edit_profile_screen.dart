import 'dart:async';
import 'package:BISOU/data/mockuser.dart';
import 'package:BISOU/models/user.dart';
import 'package:BISOU/screens/edit_phone.dart';
import 'package:BISOU/widgets/display_image.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = MockUser.adminUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.person,
              color: Color.fromARGB(255, 0, 0, 0),
              size: 28,
            ),
            const SizedBox(width: 8),
            Text(
              'Edit Profile',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..shader = const LinearGradient(
                    colors: <Color>[
                      Color.fromARGB(255, 0, 0, 0),
                      Color.fromARGB(255, 0, 0, 0),
                    ],
                  ).createShader(const Rect.fromLTWH(0.0, 0.0, 100.0, 70.0)),
              ),
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 20),
          Center(
            child: InkWell(
              onTap: () {
                //navigateSecondPage(EditImagePage());
              },
              child: DisplayImage(
                imagePath: 'assets/images/userimage.jpeg',
                onPressed: () {},
              ),
            ),
          ),
          const SizedBox(height: 20),
          buildUserInfoDisplay(
              user.firstname!, 'Name', const EditPhoneFormPage()),
          buildUserInfoDisplay(
              user.phoneNumber!, 'Phone', const EditPhoneFormPage()),
          buildUserInfoDisplay(user.email, 'Email', const EditPhoneFormPage()),
          const SizedBox(height: 20),
          buildAboutSection(user),
        ],
      ),
    );
  }

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  getValue,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              IconButton(
                onPressed: () {
                  navigateSecondPage(editPage);
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  // Widget builds the About Me Section
  Widget buildAboutSection(User user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tell Us About Yourself',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  user.lastname!,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              IconButton(
                onPressed: () {
                  navigateSecondPage(const EditPhoneFormPage());
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  // Refreshes the Page after updating user info
  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  // Handles navigation and prompts refresh
  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }
}

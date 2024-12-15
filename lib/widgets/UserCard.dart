import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String name;
  final String lastname;
  final String email;
  final String profileImage;
  final String role;
  final bool isBlocked;
  final VoidCallback onDelete;
  final VoidCallback onToggleBlock;
  final VoidCallback onViewDetails;

  const UserCard({
    Key? key,
    required this.name,
    required this.lastname,
    required this.email,
    required this.profileImage,
    required this.role,
    required this.isBlocked,
    required this.onDelete,
    required this.onToggleBlock,
    required this.onViewDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onViewDetails, // Show details when tapping anywhere on the card
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(profileImage),
          ),
          title: Text(
            '$name $lastname',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(role == 'admin' ? 'Admin' : 'User'),
              const SizedBox(height: 4),
              Text(
                email,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  isBlocked ? Icons.lock : Icons.lock_open,
                  color: isBlocked ? Colors.red : Colors.green,
                ),
                onPressed: onToggleBlock,
                tooltip: isBlocked ? 'Unblock User' : 'Block User',
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
                tooltip: 'Delete User',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

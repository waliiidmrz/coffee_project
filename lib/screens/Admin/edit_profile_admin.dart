import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class EditProfileAdminScreen extends StatefulWidget {
  final String name;
  final String lastname;
  final String phoneNumber;
  final String? birthDate;
  final String profileImageUrl;

  const EditProfileAdminScreen({
    Key? key,
    required this.name,
    required this.lastname,
    required this.phoneNumber,
    this.birthDate,
    required this.profileImageUrl,
  }) : super(key: key);

  @override
  _EditProfileAdminScreenState createState() => _EditProfileAdminScreenState();
}

class _EditProfileAdminScreenState extends State<EditProfileAdminScreen> {
  final _nameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _phoneController = TextEditingController();
  DateTime? _selectedBirthDate;
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
    _lastnameController.text = widget.lastname;
    _phoneController.text = widget.phoneNumber;
    _selectedBirthDate =
        widget.birthDate != null ? DateTime.parse(widget.birthDate!) : null;
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _saveChanges() {
    Navigator.pop(context, {
      'name': _nameController.text,
      'lastname': _lastnameController.text,
      'phoneNumber': _phoneController.text,
      'birthDate': _selectedBirthDate?.toIso8601String(),
      'profileImageUrl': _selectedImage?.path ?? widget.profileImageUrl,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: _selectedImage != null
                        ? FileImage(_selectedImage!)
                        : NetworkImage(widget.profileImageUrl) as ImageProvider,
                  ),
                  IconButton(
                    icon: const Icon(Icons.camera_alt, color: Colors.red),
                    onPressed: _pickImage,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildTextField(_nameController, 'First Name'),
            _buildTextField(_lastnameController, 'Last Name'),
            _buildTextField(_phoneController, 'Phone Number'),
            ListTile(
              leading: const Icon(Icons.cake),
              title: Text(_selectedBirthDate == null
                  ? 'Select Birthdate'
                  : 'Birthdate: ${_selectedBirthDate!.toLocal().toString().split(' ')[0]}'),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _selectedBirthDate = pickedDate;
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _saveChanges,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}

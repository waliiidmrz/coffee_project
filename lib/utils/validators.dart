class Validators {
  // Validate if the name contains only letters and at least 2 characters
  static String? validateName(String value) {
    if (value.isEmpty) {
      return 'Name is required';
    }
    if (!RegExp(r'^[a-zA-Z\s]{2,}$').hasMatch(value)) {
      return 'Enter a valid name';
    }
    return null;
  }

  static String? validateLastName(String value) {
    if (value.isEmpty) {
      return 'Last name is required';
    }
    if (!RegExp(r'^[a-zA-Z\s]{2,}$').hasMatch(value)) {
      return 'Enter a valid last name';
    }
    return null;
  }

  // Validate email format
  static String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(
            r'^[a-zA-Z0-9]+([._%+-]?[a-zA-Z0-9]+)*@[a-zA-Z0-9-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  // Validate password (at least 8 characters, includes letters and numbers)
  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    }
    if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$').hasMatch(value)) {
      return 'Password must be at least 8 characters long and include both letters and numbers';
    }
    return null;
  }

  // Validate phone number (exactly 8 digits)
  static String? validatePhoneNumber(String value) {
    if (value.isEmpty) {
      return 'Phone number is required';
    }
    if (!RegExp(r'^\d{8}$').hasMatch(value)) {
      return 'Phone number must be exactly 8 digits';
    }
    return null;
  }
}

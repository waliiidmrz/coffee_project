import 'package:http/http.dart' as http;
import 'dart:convert';

class UserService {
  static const String baseUrl = 'http://your-backend-url/api';

  // Fetch user by ID
  Future<Map<String, dynamic>> getUserById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$id'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch user');
    }
  }

  // Create a new user
  Future<bool> createUser(Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData),
    );

    return response.statusCode == 201;
  }

  // Update an existing user
  Future<bool> updateUser(int id, Map<String, dynamic> userData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/users/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData),
    );

    return response.statusCode == 200;
  }

  // Delete a user
  Future<bool> deleteUser(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/users/$id'));

    return response.statusCode == 204;
  }
}

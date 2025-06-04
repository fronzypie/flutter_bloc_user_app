import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import '../models/post_model.dart';
import '../models/todo_model.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import '../models/todo_model.dart';

class UserRepository {
  final String baseUrl = 'https://dummyjson.com';

  Future<List<User>> fetchUsers({required int skip, required int limit}) async {
    final url = Uri.parse('$baseUrl/users?skip=$skip&limit=$limit');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List usersJson = jsonData['users'] ?? [];
      return usersJson.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<List<User>> searchUsers(String query) async {
    final url = Uri.parse('$baseUrl/users/search?q=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List usersJson = jsonData['users'] ?? [];
      return usersJson.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search users');
    }
  }

  Future<List<Todo>> fetchUserTodos(int userId) async {
    final url = Uri.parse('$baseUrl/users/$userId/todos');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List todosJson = jsonData['todos'] ?? [];
      return todosJson.map((json) => Todo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load todos');
    }
  }
}

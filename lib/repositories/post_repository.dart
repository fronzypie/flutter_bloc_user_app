

import '../models/post_model.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/post_model.dart';

class PostRepository {
  final String baseUrl = 'https://dummyjson.com';

  Future<List<Post>> fetchPostsByUser(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/posts/user/$userId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final postsJson = data['posts'] as List<dynamic>;
      return postsJson.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch posts for user $userId');
    }
  }

}


import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:learning_flutter/flutter/api/restful_api/user.dart';

class ApiHttpService {
  final String apiUrl = "http://192.168.1.10:3000/users";
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    // 'User-Agent': 'FlutterApp/1.0', //Xác định thông tin ứng dụng đang sử dụng
  };

  Future<List<User>> getAlUsers() async {
    final response = await http.get(Uri.parse(apiUrl), headers: headers);
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<User> getUserById(String id) async {
    final res = await http.get(Uri.parse("$apiUrl/$id"), headers: headers);
    if (res.statusCode == 200) {
      return User.fromJson(jsonDecode(res.body));
    } else {
      throw Exception("Failed to fetch user $id");
    }
  }

  Future<User> createUser(User user) async {
    final res = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode(user.toJson()),
      headers: headers,
    );
    return User.fromJson(jsonDecode(res.body));
  }

  Future<User> updateUser(String id, User user) async {
    final res = await http.put(
      Uri.parse("$apiUrl/$id"),
      body: jsonEncode(user.toJson()),
      headers: headers,
    );
    return User.fromJson(jsonDecode(res.body));
  }

  Future<User> patchUser(String id, Map<String, dynamic> fields) async {
    final res = await http.patch(
      Uri.parse("$apiUrl/$id"),
      body: jsonEncode(fields),
      headers: headers,
    );
    return User.fromJson(jsonDecode(res.body));
  }

  Future<void> deleteUser(String id) async {
    final res = await http.delete(Uri.parse("$apiUrl/$id"),headers: headers);
    if (res.statusCode != 200) {
      throw Exception("Failed to delete user $id");
    }
  }
}

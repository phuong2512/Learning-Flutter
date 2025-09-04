import 'package:dio/dio.dart';
import 'package:learning_flutter/flutter/api/restful_api/user.dart';

class ApiDioService {
  final dio = Dio(
    BaseOptions(
      baseUrl: "http://192.168.1.10:3000",
      headers: {
        'Content-Type': 'application/json',
        // 'User-Agent':
        //     'FlutterApp/1.0',
      },
    ),
  );

  Future<List<User>> getAlUsers() async {
    final response = await dio.get('/users');
    if (response.statusCode == 200) {
      final List data = response.data;
      return data.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<User> getUserById(String id) async {
    final res = await dio.get("/users/$id");
    if (res.statusCode == 200) {
      return User.fromJson(res.data);
    } else {
      throw Exception("Failed to fetch user $id");
    }
  }

  Future<User> createUser(User user) async {
    final res = await dio.post("/users", data: user.toJson());
    return User.fromJson(res.data);
  }

  Future<User> updateUser(String id, User user) async {
    final res = await dio.put("/users/$id", data: user.toJson());
    return User.fromJson(res.data);
  }

  Future<User> patchUser(String id, Map<String, dynamic> fields) async {
    final res = await dio.patch("/users/$id", data: fields);
    return User.fromJson(res.data);
  }

  Future<void> deleteUser(String id) async {
    final res = await dio.delete("/users/$id");
    if (res.statusCode != 200) {
      throw Exception("Failed to delete user $id");
    }
  }
}

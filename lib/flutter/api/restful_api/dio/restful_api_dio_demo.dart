import 'package:flutter/material.dart';
import 'package:learning_flutter/flutter/api/restful_api/dio/api_dio_service.dart';
import 'package:learning_flutter/flutter/api/restful_api/user.dart';

void main() {
  runApp(MaterialApp(home: RestfulApiDioDemo()));
}

class RestfulApiDioDemo extends StatefulWidget {
  const RestfulApiDioDemo({super.key});

  @override
  State<RestfulApiDioDemo> createState() => _RestfulApiDioDemoState();
}

class _RestfulApiDioDemoState extends State<RestfulApiDioDemo> {
  final ApiDioService _userService = ApiDioService();
  final TextEditingController _idController = TextEditingController();
  Future<List<User>>? _futureUserData;
  void _loadAllUsers() {
    setState(() {
      _futureUserData = _userService.getAlUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Restful API Dio Demo")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              TextField(
                controller: _idController,
                decoration: const InputDecoration(
                  labelText: "User Id",
                  hintText: "Enter user id",
                ),
                onSubmitted: (value) async {
                  _getUserById(value);
                },
              ),
              ElevatedButton(
                onPressed: _loadAllUsers,
                child: const Text("Fetch Users"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: _createNewUser,
                    child: const Text("Create"),
                  ),
                  ElevatedButton(
                    onPressed: _updateUserData,
                    child: const Text("Update"),
                  ),
                  ElevatedButton(
                    onPressed: _patchUserData,
                    child: const Text("Patch"),
                  ),
                  ElevatedButton(
                    onPressed: _deleteUserData,
                    child: const Text("Delete"),
                  ),
                ],
              ),
              Expanded(
                child: FutureBuilder<List<User>>(
                  future: _futureUserData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (!snapshot.hasData) {
                      return const Center(child: Text("No data"));
                    }
                    final users = snapshot.data!;
                    return ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];
                        return ListTile(
                          title: Text(user.name),
                          subtitle: Text("${user.email}\n${user.phone}"),
                          leading: Text(user.id),
                          onTap: () async {
                            final detail = await _userService.getUserById(
                              user.id,
                            );
                            if (!context.mounted) return;
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text(detail.name),
                                content: Text(detail.toJson().toString()),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _getUserById(String id) async {
    final user = await _userService.getUserById(id);
    setState(() {
      _futureUserData = Future.value([user]);
    });
  }

  void _createNewUser() async {
    final newUser = User(
      id: DateTime.now().second.toString(), // id unique
      name: "New Dio User",
      age: 25,
      email: "dio_user@gmail.com",
    );

    final created = await _userService.createUser(newUser);
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Created: ${created.name}")));
    _loadAllUsers(); // refresh
  }

  void _updateUserData() async {
    if (_idController.text.isEmpty) return;
    final id = _idController.text;
    final updatedUser = User(
      id: id,
      name: "Updated Dio User",
      age: 30,
      email: "updated_dio@gmail.com",
      phone: "999999999",
      address: {"street": "Updated St", "city": "Updated City"},
    );

    final user = await _userService.updateUser(id, updatedUser);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Updated: ${user.name}")));
    _loadAllUsers();
    _idController.clear();
  }

  void _patchUserData() async {
    if (_idController.text.isEmpty) return;
    final id = _idController.text;
    final user = await _userService.patchUser(id, {"name": "Patched Dio User"});
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Patched: ${user.name}")));
    _loadAllUsers();
    _idController.clear();
  }

  void _deleteUserData() async {
    if (_idController.text.isEmpty) return;
    final id = _idController.text;
    await _userService.deleteUser(id);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Deleted user $id")));
    _loadAllUsers();
    _idController.clear();
  }
}

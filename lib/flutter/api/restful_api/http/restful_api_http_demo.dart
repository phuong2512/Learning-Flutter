import 'package:flutter/material.dart';
import 'package:learning_flutter/flutter/api/restful_api/http/api_http_service.dart';
import 'package:learning_flutter/flutter/api/restful_api/user.dart';

void main() {
  runApp(MaterialApp(home: RestfulApiHttpDemo()));
}

class RestfulApiHttpDemo extends StatefulWidget {
  const RestfulApiHttpDemo({super.key});

  @override
  State<RestfulApiHttpDemo> createState() => _RestfulApiHttpDemoState();
}

class _RestfulApiHttpDemoState extends State<RestfulApiHttpDemo> {
  final TextEditingController _idController = TextEditingController();

  final ApiHttpService _userService = ApiHttpService();
  Future<List<User>>? _futureUserData;
  void _loadAllUsers() {
    setState(() {
      _futureUserData = _userService.getAlUsers();
    });
  }

  void _getUserById(String id) async {
    final user = await _userService.getUserById(id);
    setState(() {
      _futureUserData = Future.value([user]);
    });
  }

  void _createNewUser() async {
    final newUser = User(
      id: "", // id unique tạm
      name: "New User",
      age: 20,
      email: "newuser@gmail.com",
      phone: "0123456789",
      address: {"street": "New Street", "city": "New City"},
    );

    final created = await _userService.createUser(newUser);
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Created: ${created.name}")));
    _loadAllUsers();
  }

  void _updateUserData() async {
    if (_idController.text.isEmpty) return;
    final id = _idController.text;
    final updatedUser = User(
      id: id,
      name: "Updated User",
      age: 30,
      email: "updated@gmail.com",
      phone: "999999999",
      address: {"street": "Updated St", "city": "Updated City"},
    );

    final user = await _userService.updateUser(id, updatedUser);
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Updated: ${user.name}")));
    _loadAllUsers();
  }

  void _patchUserData() async {
    if (_idController.text.isEmpty) return;
    final id = _idController.text;

    final user = await _userService.patchUser(id, {"name": "Patched User"});
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Patched: ${user.name}")));
    _loadAllUsers();
  }

  void _deleteUserData() async {
    if (_idController.text.isEmpty) return;
    final id = _idController.text;

    await _userService.deleteUser(id);
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Deleted user $id")));
    _loadAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Restful API Http Demo")),
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
                child: const Text("Load All Users"),
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
}

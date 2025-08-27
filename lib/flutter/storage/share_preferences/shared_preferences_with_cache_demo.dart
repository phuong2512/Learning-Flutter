import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:learning_flutter/flutter/storage/share_preferences/user.dart';

class SharedPreferencesWithCacheDemo extends StatefulWidget {
  const SharedPreferencesWithCacheDemo({super.key});

  @override
  State<SharedPreferencesWithCacheDemo> createState() =>
      _SharedPreferencesWithCacheDemoState();
}

class _SharedPreferencesWithCacheDemoState
    extends State<SharedPreferencesWithCacheDemo> {
  final _name = TextEditingController();
  final _age = TextEditingController();
  final _address = TextEditingController();
  final _phone = TextEditingController();
  String _loaded = "";

  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(),
    );
    await prefs.setString('name', user.name);
    await prefs.setInt('age', user.age);
    await prefs.setStringList('address', user.address);
    await prefs.setInt('phoneNumber', user.phoneNumber);
  }

  Future<User?> loadUser() async {
    final prefs = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(),
    );

    if (prefs.getString('name') == null) return null;

    return User(
      name: prefs.getString('name') ?? '',
      age: prefs.getInt('age') ?? 0,
      address: [],
      phoneNumber: 0,
    );
  }

  User createUserFromInput() {
    return User(
      name: _name.text,
      age: int.tryParse(_age.text) ?? 0,
      address: _address.text.split(',').map((e) => e.trim()).toList(),
      phoneNumber: int.tryParse(_phone.text) ?? 0,
    );
  }

  void showLoaded(User? user) {
    setState(() {
      _loaded = (user == null)
          ? "No data"
          : "Name: ${user.name}\nAge: ${user.age}\nAddress: ${user.address}\nPhone: ${user.phoneNumber}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SharedPreferencesWithCache")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _name,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: _age,
              decoration: const InputDecoration(labelText: "Age"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _address,
              decoration: const InputDecoration(
                labelText: "Address (comma separated)",
              ),
            ),
            TextField(
              controller: _phone,
              decoration: const InputDecoration(labelText: "Phone Number"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async => await saveUser(createUserFromInput()),
                  child: const Text("Save"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async => showLoaded(await loadUser()),
                  child: const Text("Load"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(_loaded),
          ],
        ),
      ),
    );
  }
}

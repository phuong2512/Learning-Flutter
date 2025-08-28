import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox('searchHistory');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Hive Search History',
      home: SearchScreen(),
    );
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  final _historyBox = Hive.box('searchHistory');

  void _saveSearch(String query) {
    if (query.isEmpty) return;
    final history = List<String>.from(
        _historyBox.get('history', defaultValue: <String>[]));

    history.remove(query);
    history.insert(0, query);
    if (history.length > 10) {
      history.removeLast();
    }

    _historyBox.put('history', history);

    _searchController.clear();
    FocusScope.of(context).unfocus();
  }

  Future<void> _clearHistory() async {
    log('Xóa');
    _historyBox.compact();
    await _historyBox.delete('history');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lưu Lịch Sử Tìm Kiếm'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Tìm kiếm...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => _saveSearch(_searchController.text),
                ),
              ),
              onSubmitted: (value) => _saveSearch(value),
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Lịch sử gần đây',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextButton(
                  onPressed: _clearHistory,
                  child: const Text('Xóa tất cả'),
                ),
              ],
            ),
            const Divider(),

            Expanded(
              child: ValueListenableBuilder(
                valueListenable: _historyBox.listenable(),
                builder: (context, Box box, _) {
                  final history = List<String>.from(
                      box.get('history', defaultValue: <String>[]));

                  if (history.isEmpty) {
                    return const Center(child: Text('Chưa có lịch sử tìm kiếm.'));
                  }

                  return ListView.builder(
                    itemCount: history.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(Icons.history),
                        title: Text(history[index]),
                        onTap: () {
                          // Khi người dùng nhấn vào, có thể điền lại vào ô tìm kiếm
                          _searchController.text = history[index];
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
    );
  }
}
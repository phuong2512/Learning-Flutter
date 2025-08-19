import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListDemoScreen(),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}

class ListDemoScreen extends StatelessWidget {
  final List<String> items = List.generate(
    10,
    (index) => 'Mục thứ ${index + 1}',
  );

  ListDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('List Demo'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'ListView'),
              Tab(text: 'SingleChildScrollView'),
              Tab(text: 'GridView'),
              Tab(text: 'CustomScrollView'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // ListView + ListTile
            ListView(
              children: items
                  .map(
                    (item) => ListTile(
                      leading: Icon(Icons.star),
                      title: Text(item),
                      subtitle: Text('Mô tả cho: $item'),
                      trailing: Icon(Icons.arrow_forward),
                    ),
                  )
                  .toList(),
            ),

            // SingleChildScrollView + Column
            SingleChildScrollView(
              child: Column(
                children: items
                    .map(
                      (item) => ListTile(
                        title: Text(item),
                        subtitle: Text('Column: $item'),
                      ),
                    )
                    .toList(),
              ),
            ),

            // GridView
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              padding: EdgeInsets.all(10),
              children: List.generate(
                10,
                (index) => Container(
                  child: Center(child: Text('Ô $index')),
                ),
              ),
            ),

            // CustomScrollView
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text('Sliver AppBar'),
                  floating: true,
                  expandedHeight: 100,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(color: Colors.red),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => ListTile(
                      title: Text(items[index]),
                      subtitle: Text('Sliver: ${items[index]}'),
                    ),
                    childCount: items.length,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

abstract class DatabaseStore {
  String save(String orderData);
}

class MySQLDatabase implements DatabaseStore {
  @override
  String save(String orderData) => "Đã lưu đơn hàng '$orderData' vào MySQL.";
}

class PostgreSQLDatabase implements DatabaseStore {
  @override
  String save(String orderData) =>
      "Đã lưu đơn hàng '$orderData' vào PostgreSQL.";
}

class OrderService {
  final DatabaseStore dataStore;

  OrderService(this.dataStore);

  String createOrder(String orderData) {
    if (orderData.isEmpty) {
      return "Dữ liệu đơn hàng không được để trống.";
    }
    return dataStore.save(orderData);
  }
}

class OrderScreen extends StatefulWidget {
  final OrderService orderService;

  const OrderScreen({super.key, required this.orderService});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final _textController = TextEditingController();

  void _saveOrder() {
    final result = widget.orderService.createOrder(_textController.text);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result),
        backgroundColor: result.contains('Đã lưu') ? Colors.green : Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );

    setState(() {});
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dependency Inversion Demo'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Dữ liệu đơn hàng (VD: Sách Flutter)',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveOrder,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Lưu đơn hàng'),
              ),
              const SizedBox(height: 40),
              Text('Trạng thái:', style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  final database = MySQLDatabase();
  // final database = PostgreSQLDatabase();
  final orderService = OrderService(database);

  runApp(MyApp(orderService: orderService));
}

class MyApp extends StatelessWidget {
  final OrderService orderService;

  const MyApp({super.key, required this.orderService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter DIP Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: OrderScreen(orderService: orderService),
    );
  }
}

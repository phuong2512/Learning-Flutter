import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_flutter/flutter/state_management/bloc/bloc.dart';
import 'package:learning_flutter/flutter/state_management/bloc/bloc_event.dart';
import 'package:learning_flutter/flutter/state_management/bloc/bloc_state.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => CounterBloc(),
      child:  MaterialApp(home: BlocDemoScreen()),
    ),
  );
}

class BlocDemoScreen extends StatelessWidget {
  const BlocDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BLoC Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // BlocBuilder<CounterBloc, CounterState>(
            //   builder: (context, state) {
            //     return Text('Count: ${state.count}', style: const TextStyle(fontSize: 25));
            //   },
            // ),
            const SizedBox(height: 20),
            BlocConsumer<CounterBloc, CounterState>(
              listenWhen: (previous, current) => previous.count != current.count,
              listener: (context, state) {
                final message = state.isIncremented
                    ? 'Incremented to ${state.count}'
                    : 'Decremented to ${state.count}';
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(message), duration: const Duration(milliseconds: 800)),
                );
              },
              builder: (context, state) {
                return Text(
                  'BlocConsumer View: ${state.count}',
                  style: const TextStyle(fontSize: 18, color: Colors.blue),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BlocListener<CounterBloc, CounterState>(
            listenWhen: (previous, current) => current.count == 5,
            listener: (context, state) {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Notice'),
                  content: const Text('Count reached 5!'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
            child: FloatingActionButton(
              onPressed: () => context.read<CounterBloc>().add(IncrementEvent()),
              child: const Icon(Icons.add),
            ),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => context.read<CounterBloc>().add(DecrementEvent()),
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  await initHiveForFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink('https://hasura.io/learn/graphql');

    final WebSocketLink webSocketLink = WebSocketLink(
      'wss://hasura.io/learn/graphql',  // protocol cho WebSocket secure connection
      config: SocketClientConfig(
        autoReconnect: true,
        inactivityTimeout: Duration(seconds: 30),
        initialPayload: () async => { // Gửi token authentication
          'headers': {
            'Authorization':
            'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Ik9FWTJSVGM1UlVOR05qSXhSRUV5TURJNFFUWXdNekZETWtReU1EQXdSVUV4UVVRM05EazFNQSJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWRlZmF1bHQtcm9sZSI6InVzZXIiLCJ4LWhhc3VyYS1hbGxvd2VkLXJvbGVzIjpbInVzZXIiXSwieC1oYXN1cmEtdXNlci1pZCI6ImF1dGgwfDY4YTdkZTViNGY3ZmQwY2Q4MzUwMjE1YyJ9LCJuaWNrbmFtZSI6InBodW9uZ3F2MTIiLCJuYW1lIjoicGh1b25ncXYxMkBnbWFpbC5jb20iLCJwaWN0dXJlIjoiaHR0cHM6Ly9zLmdyYXZhdGFyLmNvbS9hdmF0YXIvMDkxMDIzYTQ5YzRjZGJiNjMwMjhhZTIyZjkzMzFlYTk_cz00ODAmcj1wZyZkPWh0dHBzJTNBJTJGJTJGY2RuLmF1dGgwLmNvbSUyRmF2YXRhcnMlMkZwaC5wbmciLCJ1cGRhdGVkX2F0IjoiMjAyNS0wOC0yMlQwMzowNTowMC41MjNaIiwiaXNzIjoiaHR0cHM6Ly9ncmFwaHFsLXR1dG9yaWFscy5hdXRoMC5jb20vIiwiYXVkIjoiUDM4cW5GbzFsRkFRSnJ6a3VuLS13RXpxbGpWTkdjV1ciLCJzdWIiOiJhdXRoMHw2OGE3ZGU1YjRmN2ZkMGNkODM1MDIxNWMiLCJpYXQiOjE3NTU4MzE5MDEsImV4cCI6MTc1NTg2NzkwMSwic2lkIjoidGt2a1FCX1pLa1N0WnFtNWtaei1GTk9lRVdqX2ROR3IiLCJhdF9oYXNoIjoibTFqcHdYd0pJRkd6V1ZWMTNDckUxQSIsIm5vbmNlIjoidXdSY2h1dkd0bHJSWUlZRlBSdGlxQ05kZy01em1FZGwifQ.gF8vyzPVkCk5Ixeh6B9Oq571UyUDPJmzVRnD6beQ0stOC1fzmJbXHxmzIrYetlcqeSLnwy2bFCglj5Uq9kIRNo0l5EgZ-AzSG6UtLke2m4hkwcXnwbFuz_jEsfx0QUE__DMuDSgR_A5vHub3IOd68rKSnrVife9NZT68tYP22gmGmeuan2Jksx-llpI18chEOVnHQSWh-oXYCmeoNRb_Hr6zJYwmYkTqoYaU4ULGPigCYCDgu-9r8qUUs-XeSQHdwWf4W_nGe_tp8_h_pxjFwn7i8Y7niDPeQ_QY3m-0zphZJSMFub8Lb4x6G2L_XcA2ybp5mSVUttwGN0chD463hg'
          }
        },
      ),
    );

    final AuthLink authLink = AuthLink( //Thêm token authentication vào HTTP headers
      getToken: () async =>
      'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Ik9FWTJSVGM1UlVOR05qSXhSRUV5TURJNFFUWXdNekZETWtReU1EQXdSVUV4UVVRM05EazFNQSJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWRlZmF1bHQtcm9sZSI6InVzZXIiLCJ4LWhhc3VyYS1hbGxvd2VkLXJvbGVzIjpbInVzZXIiXSwieC1oYXN1cmEtdXNlci1pZCI6ImF1dGgwfDY4YTdkZTViNGY3ZmQwY2Q4MzUwMjE1YyJ9LCJuaWNrbmFtZSI6InBodW9uZ3F2MTIiLCJuYW1lIjoicGh1b25ncXYxMkBnbWFpbC5jb20iLCJwaWN0dXJlIjoiaHR0cHM6Ly9zLmdyYXZhdGFyLmNvbS9hdmF0YXIvMDkxMDIzYTQ5YzRjZGJiNjMwMjhhZTIyZjkzMzFlYTk_cz00ODAmcj1wZyZkPWh0dHBzJTNBJTJGJTJGY2RuLmF1dGgwLmNvbSUyRmF2YXRhcnMlMkZwaC5wbmciLCJ1cGRhdGVkX2F0IjoiMjAyNS0wOC0yMlQwMzowNTowMC41MjNaIiwiaXNzIjoiaHR0cHM6Ly9ncmFwaHFsLXR1dG9yaWFscy5hdXRoMC5jb20vIiwiYXVkIjoiUDM4cW5GbzFsRkFRSnJ6a3VuLS13RXpxbGpWTkdjV1ciLCJzdWIiOiJhdXRoMHw2OGE3ZGU1YjRmN2ZkMGNkODM1MDIxNWMiLCJpYXQiOjE3NTU4MzE5MDEsImV4cCI6MTc1NTg2NzkwMSwic2lkIjoidGt2a1FCX1pLa1N0WnFtNWtaei1GTk9lRVdqX2ROR3IiLCJhdF9oYXNoIjoibTFqcHdYd0pJRkd6V1ZWMTNDckUxQSIsIm5vbmNlIjoidXdSY2h1dkG0bHJSWUlZRlBSdGlxQ05kZy01em1FZGwifQ.gF8vyzPVkCk5Ixeh6B9Oq571UyUDPJmzVRnD6beQ0stOC1fzmJbXHxmzIrYetlcqeSLnwy2bFCglj5Uq9kIRNo0l5EgZ-AzSG6UtLke2m4hkwcXnwbFuz_jEsfx0QUE__DMuDSgR_A5vHub3IOd68rKSnrVife9NZT68tYP22gmGmeuan2Jksx-llpI18chEOVnHQSWh-oXYCmeoNRb_Hr6zJYwmYkTqoYaU4ULGPigCYCDgu-9r8qUUs-XeSQHdwWf4W_nGe_tp8_h_pxjFwn7i8Y7niDPeQ_QY3m-0zphZJSMFub8Lb4x6G2L_XcA2ybp5mSVUttwGN0chD463hg',
    );

    final Link httpLinkWithAuth = authLink.concat(httpLink);// Tạo một link chain xử lý authentication trước khi gửi HTTP request

    //Phân loại request để gửi qua đúng protocol
    final Link link = Link.split(
          (request) => request.isSubscription,
      webSocketLink,
      httpLinkWithAuth,
    );

    final ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        cache: GraphQLCache(store: HiveStore()),
        link: link,
      ),
    );

    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: 'Todo App with GraphQL Subscription',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: TodoListScreen(),
      ),
    );
  }
}

class TodoListScreen extends StatelessWidget {
  final String subscriptionQuery = '''
  subscription sub {
    todos(where: {id: {_gt: 457730}}) {
      id
      title
      is_completed
    }
  }
  ''';

  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Real-Time Todos')),
      body: Subscription(
        options: SubscriptionOptions(document: gql(subscriptionQuery)),
        builder: (result) {
          if (result.hasException) {
            log(result.exception.toString());
            return Center(child: Text(result.exception.toString()));
          }

          if (result.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          final todos = result.data?['todos'] as List<dynamic>? ?? [];

          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return ListTile(
                title: Text(todo['title']),
                trailing: Icon(
                  todo['is_completed']
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: todo['is_completed'] ? Colors.green : Colors.grey,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

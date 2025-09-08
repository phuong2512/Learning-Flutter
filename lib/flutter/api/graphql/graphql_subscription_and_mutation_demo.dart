import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  await initHiveForFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink('https://hasura.io/learn/graphql');
    final String authToken =
        'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Ik9FWTJSVGM1UlVOR05qSXhSRUV5TURJNFFUWXdNekZETWtReU1EQXdSVUV4UVVRM05EazFNQSJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWRlZmF1bHQtcm9sZSI6InVzZXIiLCJ4LWhhc3VyYS1hbGxvd2VkLXJvbGVzIjpbInVzZXIiXSwieC1oYXN1cmEtdXNlci1pZCI6ImF1dGgwfDY4YTdkZTViNGY3ZmQwY2Q4MzUwMjE1YyJ9LCJuaWNrbmFtZSI6InBodW9uZ3F2MTIiLCJuYW1lIjoicGh1b25ncXYxMkBnbWFpbC5jb20iLCJwaWN0dXJlIjoiaHR0cHM6Ly9zLmdyYXZhdGFyLmNvbS9hdmF0YXIvMDkxMDIzYTQ5YzRjZGJiNjMwMjhhZTIyZjkzMzFlYTk_cz00ODAmcj1wZyZkPWh0dHBzJTNBJTJGJTJGY2RuLmF1dGgwLmNvbSUyRmF2YXRhcnMlMkZwaC5wbmciLCJ1cGRhdGVkX2F0IjoiMjAyNS0wOS0wOFQwMjo1NDoyMS4zODhaIiwiaXNzIjoiaHR0cHM6Ly9ncmFwaHFsLXR1dG9yaWFscy5hdXRoMC5jb20vIiwiYXVkIjoiUDM4cW5GbzFsRkFRSnJ6a3VuLS13RXpxbGpWTkdjV1ciLCJzdWIiOiJhdXRoMHw2OGE3ZGU1YjRmN2ZkMGNkODM1MDIxNWMiLCJpYXQiOjE3NTczMDAwNjIsImV4cCI6MTc1NzMzNjA2Miwic2lkIjoiVmtkMENyZlRaUGdnN2dBODRoSmh2Rjczc2ltLTVCUTgiLCJhdF9oYXNoIjoiY3VsUzZveUNWM2JNRnNMekNURlp6QSIsIm5vbmNlIjoiTXdRWHF4UXRHR1MxbEJaNH5IdUwwVnJTOG9kTVppajkifQ.jPxWJQH9YR_rDzyBgVr0ZreEmiT-07HaM9jPIaFUwJozvsNe77TDjRMb7jPgmafMTixbbU6wwOz56eCQtjCtonKVtFUMlTBrLV6vF4PMhW9SE61nZdaCLxy78xAcStInwj3rUyVK1qTu2GIgubayXIw0-d8P8IryCB8ILGoWhZ8opKw9IzBFE13yU1j2_jQZomWWbSsOzYd2BQp0zLpoAQc30OL5B08dnij-d2NiUpZ5Rv6W3jX7uaZqJXzZz8D25ki3Xrft2WyTaH8OK-ro1iTpWMSYX4SdbOpOxAtJYA6eSg1l0c5Xa48cMIje_H1F05FNOnrj30JloCEz1wd33w';

    final WebSocketLink webSocketLink = WebSocketLink(
      'wss://hasura.io/learn/graphql',
      config: SocketClientConfig(
        autoReconnect: true,
        inactivityTimeout: const Duration(seconds: 30),
        initialPayload: () async => {
          'headers': {'Authorization': authToken},
        },
      ),
    );

    final AuthLink authLink = AuthLink(getToken: () async => authToken);

    final Link httpLinkWithAuth = authLink.concat(httpLink);

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
        home: const GraphQLSubscriptionAndMutationDemoScreen(),
      ),
    );
  }
}

class GraphQLSubscriptionAndMutationDemoScreen extends StatelessWidget {
  final String subscriptionQuery = '''
  subscription sub {
    todos(where: {id: {_gt: 457985}}, order_by: {id: desc}) {
      id
      title
      is_completed
      created_at
    }
  }
  ''';

  final String mutationCreate = r'''
  mutation insertTodo($title: String!) {
    insert_todos(objects: {title: $title}) {
      returning {
        created_at
        is_completed
        title
        id
      }
    }
  }
  ''';

  final String mutationUpdate = r'''
  mutation updateTodo($id: Int!, $title: String!, $isCompleted: Boolean!) {
    update_todos(where: {id: {_eq: $id}}, _set: {is_completed: $isCompleted, title: $title}) {
      returning {
        id
        is_completed
        title
      }
    }
  }
  ''';
  final String mutationDelete = r'''
  mutation deleteTodo($id: Int!) {
    delete_todos(where: {id: {_eq: $id}}) {
      returning {
        id
      }
    }
  }
  ''';

  const GraphQLSubscriptionAndMutationDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GraphQL Todos')),
      body: SafeArea(
        child: Column(
          children: [
            Mutation(
              options: MutationOptions(
                document: gql(mutationCreate),
                onCompleted: (data) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Todo created successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                onError: (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to create todo: $error'),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
              ),
              builder: (RunMutation runMutation, QueryResult? result) {
                return ElevatedButton(
                  onPressed: () {
                    runMutation({'title': 'Create new todo ${DateTime.now()}'});
                  },
                  child: const Text('Add Todo'),
                );
              },
            ),
            Expanded(
              child: Subscription(
                options: SubscriptionOptions(document: gql(subscriptionQuery)),
                builder: (result) {
                  if (result.hasException) {
                    log(result.exception.toString());
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('An error occurred. Please try again.'),
                          ElevatedButton(
                            onPressed: () =>
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Retrying...')),
                                ),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (result.isLoading && result.data == null) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final todos = result.data?['todos'] as List<dynamic>? ?? [];

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final todo = todos[index];
                      return ListTile(
                        title: Text('${todo['id']} - ${todo['title']}'),
                        subtitle: Text(
                          'Created: ${DateTime.parse(todo['created_at']).toLocal()}',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Mutation(
                              options: MutationOptions(
                                document: gql(mutationDelete),
                                onCompleted: (data) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Todo with id ${todo['id']} delete successfully!',
                                      ),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                },
                                onError: (error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Failed to delete todo: $error',
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                },
                              ),
                              builder:
                                  (
                                    RunMutation runMutation,
                                    QueryResult? result,
                                  ) {
                                    return IconButton(
                                      onPressed: () {
                                        runMutation({'id': todo['id']});
                                      },
                                      icon: Icon(Icons.delete_outline),
                                    );
                                  },
                            ),
                            Mutation(
                              options: MutationOptions(
                                document: gql(mutationUpdate),
                              ),
                              builder:
                                  (
                                    RunMutation runMutation,
                                    QueryResult? result,
                                  ) {
                                    return IconButton(
                                      icon: Icon(
                                        todo['is_completed']
                                            ? Icons.check_circle
                                            : Icons.radio_button_unchecked,
                                        color: todo['is_completed']
                                            ? Colors.green
                                            : Colors.grey,
                                      ),
                                      onPressed: () {
                                        runMutation({
                                          'id': todo['id'],
                                          'title': todo['title'],
                                          'isCompleted': !todo['is_completed'],
                                        });
                                      },
                                    );
                                  },
                            ),
                          ],
                        ),
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

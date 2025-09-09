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
        'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Ik9FWTJSVGM1UlVOR05qSXhSRUV5TURJNFFUWXdNekZETWtReU1EQXdSVUV4UVVRM05EazFNQSJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWRlZmF1bHQtcm9sZSI6InVzZXIiLCJ4LWhhc3VyYS1hbGxvd2VkLXJvbGVzIjpbInVzZXIiXSwieC1oYXN1cmEtdXNlci1pZCI6ImF1dGgwfDY4YTdkZTViNGY3ZmQwY2Q4MzUwMjE1YyJ9LCJuaWNrbmFtZSI6InBodW9uZ3F2MTIiLCJuYW1lIjoicGh1b25ncXYxMkBnbWFpbC5jb20iLCJwaWN0dXJlIjoiaHR0cHM6Ly9zLmdyYXZhdGFyLmNvbS9hdmF0YXIvMDkxMDIzYTQ5YzRjZGJiNjMwMjhhZTIyZjkzMzFlYTk_cz00ODAmcj1wZyZkPWh0dHBzJTNBJTJGJTJGY2RuLmF1dGgwLmNvbSUyRmF2YXRhcnMlMkZwaC5wbmciLCJ1cGRhdGVkX2F0IjoiMjAyNS0wOS0wOFQwMjo1NDoyMS4zODhaIiwiaXNzIjoiaHR0cHM6Ly9ncmFwaHFsLXR1dG9yaWFscy5hdXRoMC5jb20vIiwiYXVkIjoiUDM4cW5GbzFsRkFRSnJ6a3VuLS13RXpxbGpWTkdjV1ciLCJzdWIiOiJhdXRoMHw2OGE3ZGU1YjRmN2ZkMGNkODM1MDIxNWMiLCJpYXQiOjE3NTc0MDYyODksImV4cCI6MTc1NzQ0MjI4OSwic2lkIjoiVmtkMENyZlRaUGdnN2dBODRoSmh2Rjczc2ltLTVCUTgiLCJhdF9oYXNoIjoiVTRVMURKaXRpaWR3N0VwanM1TkM5QSIsIm5vbmNlIjoiLk5GWk5CeG8wYkZDUm9IUE1WOFhSMDIuRmtCbDNEX0wifQ.MIQlzVGHXeYF_Iy3J1MbfBk-jaTIyB5ybPNvANNvm3e2AkSaePGXmQVd2bL1IOyyVT5vSlHDH9_mOrBx9jLcMRHyu7gdgCSb3aR4AVeu-6VkfmOUG1tKc4VhyxAoOSib8ofrC0LDzlPShxZ7HV_AHWwDSYA3CHZPQbtQYS04TqV4Xdcc5Bk8Z89y9CKdR2hCTrrdKJFKE5ctfzsobc4dMoprr10_N1V89IpZKD5qABPzAL1qJx4Z9jQnkl_JSZ2BDrFO7TNQgk_rQIh3ab16AxMS9YtV5i6Nl7omwPEhS241wTp-zZnWq_AhjieLseJSdy4FEq58525-cPnzZ0l4JA';

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
      affected_rows
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
      affected_rows
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
      affected_rows
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
                  final affectedRows = data?['insert_todos']?['affected_rows'] ?? 0;
                  if (affectedRows > 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Todo created successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Failed to create todo.'),
                        backgroundColor: Colors.orange,
                      ),
                    );
                  }
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
                                  final affectedRows = data?['delete_todos']?['affected_rows'] ?? 0;
                                  if (affectedRows > 0) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Todo with id ${todo['id']} deleted!'),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Delete failed'),
                                        backgroundColor: Colors.orange,
                                      ),
                                    );
                                  }
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

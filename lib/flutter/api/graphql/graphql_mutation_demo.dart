import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  await initHiveForFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final HttpLink httpLink = HttpLink("https://graphqlzero.almansi.me/api");

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(store: InMemoryStore()),
      ),
    );

    return GraphQLProvider(
      client: client,
      child: MaterialApp(home: TodoScreen()),
    );
  }
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final _idController = TextEditingController();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final createPostMutation = r'''
  mutation createPost($title: String!, $body: String!) {
    createPost(input: { title: $title, body: $body }) {
      id
      title
      body
    }
  }
  ''';

  final updatePostMutation = r'''
  mutation updatePost($id: ID!, $title: String!, $body: String!) {
    updatePost(id: $id, input: { title: $title, body: $body }) {
      id
      title
      body
    }
  }''';

  final deletePostMutation = r'''
  mutation deletePost($id: ID!) {
    deletePost(id: $id)
  }''';

  @override
  void dispose() {
    _idController.dispose();
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GraphQL Mutation Demo")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _idController,
                decoration: const InputDecoration(labelText: 'Id'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _bodyController,
                decoration: const InputDecoration(labelText: 'Body'),
              ),
              SizedBox(width: 8),
              Mutation(
                options: MutationOptions(
                  document: gql(createPostMutation),
                  onCompleted: (data) {
                    if (data != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Post created: ${data['createPost']['id']}',
                          ),
                        ),
                      );
                    }
                  },
                  onError: (error) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Error: $error')));
                  },
                ),
                builder: (RunMutation runMutation, QueryResult? result) {
                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: () => _createPost(runMutation),
                        child: const Text('Create Post'),
                      ),
                      if (result?.isLoading ?? false)
                        const CircularProgressIndicator(),
                      if (result?.hasException ?? false)
                        Text('Error: ${result!.exception.toString()}'),
                      if (result?.data != null)
                        _mutationResult(result!.data!['createPost']),
                    ],
                  );
                },
              ),
              Mutation(
                options: MutationOptions(
                  document: gql(updatePostMutation),
                  onCompleted: (data) {
                    if (data != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Post Updated: ${data['updatePost']['id']}',
                          ),
                        ),
                      );
                    }
                  },
                  onError: (error) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Error: $error')));
                  },
                ),
                builder: (RunMutation runMutation, QueryResult? result) {
                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: () => _updatePost(runMutation),
                        child: const Text('Update'),
                      ),
                      if (result?.isLoading ?? false)
                        const CircularProgressIndicator(),
                      if (result?.hasException ?? false)
                        Text('Error: ${result!.exception.toString()}'),
                      if (result?.data != null)
                        _mutationResult(result!.data!['updatePost']),
                    ],
                  );
                },
              ),
              Mutation(
                options: MutationOptions(
                  document: gql(deletePostMutation),
                  onCompleted: (data) {
                    if (data != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Post deleted successfully')),
                      );
                    }
                  },
                  onError: (error) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Error: $error')));
                    log(error.toString());
                  },
                ),
                builder: (RunMutation runMutation, QueryResult? result) {
                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: () => _deletePost(runMutation),
                        child: const Text('Delete Post'),
                      ),
                      if (result?.isLoading ?? false)
                        const CircularProgressIndicator(),
                      if (result?.hasException ?? false)
                        Text('Error: ${result!.exception.toString()}'),

                      if (result?.data != null)
                        const Text(
                          'Deleted successfully',
                          style: TextStyle(color: Colors.green),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mutationResult(Map<String, dynamic> post) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Post ID: ${post['id']}'),
        Text('Title: ${post['title']}'),
        Text('Body: ${post['body']}'),
      ],
    );
  }

  void _createPost(RunMutation runMutation) {
    final title = _titleController.text.trim();
    final body = _bodyController.text.trim();
    if (title.isNotEmpty && body.isNotEmpty) {
      runMutation({'title': title, 'body': body});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in title and body')),
      );
    }
  }

  // Hàm xử lý Update Post
  void _updatePost(RunMutation runMutation) {
    final id = _idController.text.trim();
    final String title = _titleController.text.trim();
    final String body = _bodyController.text.trim();
    if (id.isNotEmpty) {
      runMutation({'id': id, 'title': title, 'body': body});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in ID, title, and body')),
      );
    }
  }

  // Hàm xử lý Delete Post
  void _deletePost(RunMutation runMutation) {
    final id = _idController.text.trim();
    if (id.isNotEmpty) {
      runMutation({'id': id});
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please fill in post ID')));
    }
  }
}

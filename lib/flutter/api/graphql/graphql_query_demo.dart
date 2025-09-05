import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final HttpLink httpLink = HttpLink("https://countries.trevorblades.com/");

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(link: httpLink, cache: GraphQLCache()),
  );

  runApp(MyApp(client: client));
}

class MyApp extends StatelessWidget {
  final ValueNotifier<GraphQLClient> client;
  const MyApp({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: const CacheProvider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: CountryListScreen(),
        ),
      ),
    );
  }
}

class CountryListScreen extends StatefulWidget {
  const CountryListScreen({super.key});

  @override
  State<CountryListScreen> createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  final String query = """
    query {
      countries {
        code
        name
        emoji
      }
    }
  """;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Countries (limit 50)")),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Query(
                  options: QueryOptions(document: gql(query)),
                  builder:
                      (
                        QueryResult result, {
                        VoidCallback? refetch,
                        FetchMore? fetchMore,
                      }) {
                        if (result.isLoading) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        if (result.hasException) {
                          return Center(
                            child: Text("Error: ${result.exception.toString()}"),
                          );
                        }

                        final List countries = result.data?['countries'] ?? [];
                        final limitedCountries = countries.take(50).toList();

                        return ListView.builder(
                          itemCount: limitedCountries.length,
                          itemBuilder: (context, index) {
                            final country = limitedCountries[index];
                            return ListTile(
                              title: Text(
                                "${country['name']} ${country['emoji']}",
                              ),
                              subtitle: Text("Code: ${country['code']}"),
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

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:queryui/view/Bottomnavbar/Bottomnavbar.dart';

void main() async {
  await initHiveForFlutter();
  
  final client = GraphQLClient(
    link: HttpLink('https://rickandmortyapi.com/graphql'),
    cache: GraphQLCache(store: HiveStore()),
  );

  final notifier = ValueNotifier(client);

  runApp(MyApp(client: notifier));
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
          home: Bottomnavbar(),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class GetData extends StatefulWidget {
  const GetData({Key? key}) : super(key: key);

  @override
  State<GetData> createState() => _GetDataState();
}

class _GetDataState extends State<GetData> {
  late Future<List<ParseObject>> futureData;

  @override
  void initState() {
    super.initState();
  }

  String getAllGameScores = '''
query getSomeGameScores{
  gameScores {
    pageInfo {
      hasNextPage
      hasPreviousPage
      startCursor
      endCursor
    }
    count
    edges {
      cursor
      node {
        id
        playerName
        score
        cheatmode
      }
    }
  }
}
''';

  @override
  Widget build(BuildContext context) {
    Widget scoressSection = Container(
        child: Column(
      children: [
        Query(
            options: QueryOptions(
              document: gql(getAllGameScores),
              pollInterval: const Duration(seconds: 10),
            ),
            builder: (QueryResult result,
                {VoidCallback? refetch, FetchMore? fetchMore}) {
              if (result.hasException) {
                print(result.exception.toString());
                return Text(result.exception.toString());
              }

              if (result.isLoading) {
                //  return const Text('Loading');
                return const CircularProgressIndicator();
              }

              var edges = result.data!["gameScores"]["edges"];
              print(result.data!["gameScores"]["count"]);

              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: result.data!["gameScores"]["count"],
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: const Icon(Icons.scoreboard),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Player Name:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(edges[index]["node"]["playerName"]),
                              const Text(
                                "Score:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                edges[index]["node"]["score"].toString(),
                              ),
                            ],
                          ),
                          subtitle: Text(
                              "CheatMode Enabled:  ${edges[index]["node"]["cheatmode"]}"),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
      ],
    ));

    return Scaffold(
        appBar: AppBar(
          title: const Text('Gamescore'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                const Text(
                  'Gamescores',
                  textScaleFactor: 2,
                ),
                const SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    scoressSection,
                  ],
                ),
              ],
            )));
  }
}

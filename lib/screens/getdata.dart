import 'package:flutter/material.dart';
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
    futureData = fetchData();
  }

  Future<List<ParseObject>> fetchData() async {
    var apiResponse = await ParseObject('GameScore').getAll();

    if (apiResponse.success) {
      if (apiResponse.result != null) {
        return apiResponse.result;
      } else {
        return [];
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to retrieve GameScores');
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget scoressSection = Container(
      child: Column(
        children: [
          FutureBuilder<List<ParseObject>>(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data);
                print(snapshot.data!.length);
                //               for (var testObject in (snapshot.data)!) {
                //                 print(testObject.toString());
                //                 print(testObject['score']);
                //               }

                List<ParseObject>? data = snapshot.data;
                print(data);
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: snapshot.data!.length,
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
                                Text(data![index]['playerName']),
                                const Text(
                                  "Score:",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  data[index]['score'].toString(),
                                ),
                              ],
                            ),
                            subtitle: Text(
                                "CheatMode Enabled:  ${data[index]['cheatmode']}"),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          )
        ],
      ),
    );

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
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Refresh'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GetData(),
                          ),
                        );
                      },
                    )),
              ],
            )));

/*        return Wrap(
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
    );*/
  }
}

import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class PutData extends StatefulWidget {
  const PutData({Key? key}) : super(key: key);

  @override
  State<PutData> createState() => _PutDataState();
}

class _PutDataState extends State<PutData> {
  TextEditingController nameController = TextEditingController();
  TextEditingController scoreController = TextEditingController();
  bool? check1 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Gamescore'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Enter Gamescore',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Player Name',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    controller: scoreController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Score',
                    ),
                  ),
                ),
                Container(
                  child: CheckboxListTile(
                    value: check1,
                    onChanged: (bool? value) {
                      setState(() {
                        check1 = value;
                      });
                    },
                    title: const Text("CheatMode Enabled?"),
                  ),
                ),
                Container(
                    height: 75,
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Enter'),
                      onPressed: () {
                        print("Controller name = ${nameController.text}");
                        print("Controller score = ${scoreController.text}");
                        print("Cheat Enabled = $check1");
                        enterGameScore(context, nameController.text,
                            scoreController.text, check1);
                        scoreController.clear();
                        nameController.clear();
                      },
                    )),
              ],
            )));
  }

  enterGameScore(context, playerName, score, cheatModeEnabled) async {
    var resp = await ParseSession().getCurrentSessionFromServer();
    if (resp.success) {
      ParseSession session = resp.result;
      print(resp.result);
      session.set("myData", "This is my String");
      var apiResponse = await session.save();
      if (apiResponse.success) {
        print(apiResponse.result);
      } else {
        print(apiResponse.error?.message);
      }
    } else {
      print(resp.error?.message);
    }

    var scoreNum = int.parse(score);
    // Create a new Gamescore document
    var gamescoreObject = ParseObject('GameScore')
      ..set('playerName', playerName)
      ..set('score', scoreNum)
      ..set('cheatmode', cheatModeEnabled);
    // And save it
    var response = await gamescoreObject.save();
    if (response.success) {
      gamescoreObject = response.results?.first;
    } else {
      // set up the button
      Widget okButton = TextButton(
        child: const Text("OK"),
        onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
      );
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: const Text("Error Dialog"),
        content: Text('${response.error?.message}'),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }
}

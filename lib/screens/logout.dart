import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class Logout extends StatelessWidget {
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
                      'Are You Sure?',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    height: 75,
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Log OUT'),
                      onPressed: () {
                        print("Logging Out");
                        processLogout();
                        GoRouter.of(context).go('/');
                        // Do the Logout
                      },
                    )),
              ],
            )));
  }

  processLogout() async {
    final String? sessionId = ParseCoreData().sessionId;
    print(sessionId);
    var user = await ParseUser.currentUser();
    print(user);

    var resp = await ParseSession().getCurrentSessionFromServer();
    if (resp.success) {
      ParseSession session = resp.result;
      print(session.runtimeType);
      print(session);
      var myData = session.get("myData");
      print(myData);
    } else {
      print(resp.error?.message);
    }

    var response = await user.logout();
    if (response.success) {
      print('User logout success');
    } else {
      print('User logout failure response = ' + response);
    }
  }
}

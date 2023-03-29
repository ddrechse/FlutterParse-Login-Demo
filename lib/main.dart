import 'dart:io';

import 'package:flutter/material.dart';
import 'package:parse_login_demo/screens/login.dart';
import 'package:parse_login_demo/screens/signup.dart';
import 'package:parse_login_demo/screens/homepage.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'package:go_router/go_router.dart';

void main() async {
  //  Parse code
  WidgetsFlutterBinding.ensureInitialized();
  const keyApplicationId = 'APPLICATION_ID';
  const keyParseServerUrl = 'http://***.**.***.**/parse';

  var response = await Parse().initialize(keyApplicationId, keyParseServerUrl);
  if (!response.hasParseBeenInitialized()) {
    // https://stackoverflow.com/questions/45109557/flutter-how-to-programmatically-exit-the-app
    exit(0);
  }
  var firstObject = ParseObject('FirstClass')
    ..set('message', 'Parse Login Demo is Connected');
  await firstObject.save();

  print('done');
// Parse code done
  runApp(const MyApp());
}

// GoRouter configuration
final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Login(),
    ),
    GoRoute(
      path: '/homepage',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignUp(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}

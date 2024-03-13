import 'package:flutter/material.dart';
import 'package:parse_login_demo/screens/getdata.dart';
import 'package:parse_login_demo/screens/logout.dart';
import 'package:parse_login_demo/screens/putdata.dart';
import '../components/persistent_bottom_bar_scaffold.dart';

class HomePage extends StatelessWidget {
  final _tab1navigatorKey = GlobalKey<NavigatorState>();
  final _tab2navigatorKey = GlobalKey<NavigatorState>();
  final _tab3navigatorKey = GlobalKey<NavigatorState>();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PersistentBottomBarScaffold(
      items: [
        PersistentTabItem(
          tab: const PutData(),
          icon: Icons.arrow_upward,
          title: 'Enter Gamescores',
          navigatorkey: _tab1navigatorKey,
        ),
        PersistentTabItem(
          tab: const GetData(),
          icon: Icons.arrow_downward,
          title: 'List Gamescores',
          navigatorkey: _tab2navigatorKey,
        ),
        PersistentTabItem(
          tab: const Logout(),
          icon: Icons.logout_sharp,
          title: 'Logout',
          navigatorkey: _tab3navigatorKey,
        ),
      ],
    );
  }
}

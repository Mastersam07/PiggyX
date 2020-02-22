import 'package:flutter/material.dart';
import 'package:PiggyX/services/auth.dart';
import 'package:PiggyX/services/auth_provider.dart';
import 'package:PiggyX/ui/rootpage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: Auth(),
      child: MaterialApp(
        title: 'PiggyX',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: RootPage(),
      ),
    );
  }
}

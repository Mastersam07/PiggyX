import 'package:flutter/material.dart';
import 'package:PiggyX/services/auth.dart';
import 'package:PiggyX/services/auth_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({this.onSignedOut});
  final VoidCallback onSignedOut;

  Future<void> _signOut(BuildContext context) async {
    try {
      final BaseAuth auth = AuthProvider.of(context).auth;
//      await auth.signOut();
      await auth.signOutGoogle();
      onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        actions: <Widget>[
          FlatButton(
            child: Text('SignOut', style: TextStyle(fontSize: 17.0, color: Colors.white)),
            onPressed: () => _signOut(context),
          )
        ],
      ),
      body: Container(
        child: Center(child: Text('Welcome to PiggyX', style: TextStyle(fontSize: 32.0))),
      ),
    );
  }
}

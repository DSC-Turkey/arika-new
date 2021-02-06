import 'package:arika/provider/auth_provider.dart';
import 'package:arika/ui/landing_page.dart';
import 'package:arika/utils/exception_handlers/auth_exception_handler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Container(
        child: Center(
          child: TextButton(
            onPressed: () {
              _authProvider.signOut().then((value) {
                if (value != AuthResultStatus.successful) {
                  // ScaffoldMessenger.of(context)
                  //     .showSnackBar(SnackBar(content: Text(value)));
                } else {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LandingPage()),
                      (route) => false);
                }
              });
            },
            child: Text(
              "Çıkış Yap",
              style: TextStyle(
                  color: Colors.blue.shade800,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
          ),
        ),
      ),
    );
  }
}

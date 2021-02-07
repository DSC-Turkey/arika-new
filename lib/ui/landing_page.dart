import 'package:arika/provider/auth_provider.dart';
import 'package:arika/ui/drive/orgin.dart';
import 'package:arika/ui/splash_page/splash_pages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    if (_authProvider.thisUser == null) {
      return SplashPages();
    } else {
      return Orgin();
    }
  }
}

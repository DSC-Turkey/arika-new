import 'package:flutter/material.dart';

import 'drawerScreen.dart';
import 'homeScreen.dart';

class Orgin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [DrawerScreen(name: 'Muhammed',), HomeScreen(),],
      ),
    );
  }
}

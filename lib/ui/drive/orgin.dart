import 'package:arika/ui/home_page.dart';
import 'package:flutter/material.dart';

import 'drawerScreen.dart';

class Orgin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(
            name: 'Muhammed',
          ),
          HomePage(),
        ],
      ),
    );
  }
}

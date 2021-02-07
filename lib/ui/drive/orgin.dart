<<<<<<< HEAD
import 'package:arika/ui/home_page.dart';
import 'package:flutter/material.dart';

import 'drawerScreen.dart';
=======
import 'package:flutter/material.dart';

import 'drawerScreen.dart';
import 'homeScreen.dart';
>>>>>>> master/master

class Orgin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
<<<<<<< HEAD
        children: [
          DrawerScreen(
            name: 'Muhammed',
          ),
          HomePage(),
        ],
=======
        children: [DrawerScreen(name: 'Muhammed',), HomeScreen(),],
>>>>>>> master/master
      ),
    );
  }
}

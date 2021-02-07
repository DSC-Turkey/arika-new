import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MoneyBox extends StatefulWidget {
  @override
  _MoneyBoxState createState() => _MoneyBoxState();
}

class _MoneyBoxState extends State<MoneyBox> {
  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1252C2), Color(0xFFFFFFFF)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width*0.5,

              child: SvgPicture.asset('assets/images/kumbaram.svg'),
            ),
          ],
        ),
      ),
    );
  }
}

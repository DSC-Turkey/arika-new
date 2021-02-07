import 'package:arika/ui/auth/sign.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Chose extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //backgroundColor: Color(0xFF97A7C3), //Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1252C2), Color(0xFFFFFFFF)],
          ),
        ),
        child: Stack(
          children: [
            photoPart(size, size.height * 0.05, size.width * 0.25),
            button(context, size, size.height * 0.4, size.width * 0.25),
            logo(size, size.height * 0.75, 0.0)
          ],
        ),
      ),
    );
  }

  photoPart(Size size, double x, double y) {
    return Positioned(
      top: x,
      left: y,
      child: Container(
        width: size.width * 0.5,
        height: size.width * 0.5,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              blurRadius: 25.0, // soften the shadow
              spreadRadius: 5.0, //extend the shadow
              offset: Offset(
                -15.0,
                -15.0,
              ),
            )
          ],
          shape: BoxShape.circle,
          image: DecorationImage(
              image: AssetImage('assets/images/birds.png'), fit: BoxFit.fill),
        ),
      ),
    );
  }

  button(BuildContext context, Size size, double x, double y) {
    return Positioned(
      top: x,
      left: y,
      child: Container(
          width: size.width * 0.5,
          height: size.width * 0.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              stayledButton(size, () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Sign(
                      isTeacher: false,
                      context: context,
                    ),
                  ),
                );
              }, 'Öğrenci'),
              stayledButton(size, () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Sign(
                      isTeacher: true,
                      context: context,
                    ),
                  ),
                );
              }, 'Öğretici'),
            ],
          )),
    );
  }

  stayledButton(Size size, Function f, String title) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.6),
            blurRadius: 25.0, // soften the shadow
            spreadRadius: 5.0, //extend the shadow
            offset: Offset(
              -15.0,
              -15.0,
            ),
          )
        ],
        shape: BoxShape.rectangle,
      ),
      height: size.height * 0.08,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        onPressed: f,
        child: Text(title),
      ),
    );
  }

  logo(Size size, double x, double y) {
    return Positioned(
      top: x,
      left: y,
      child: Container(
        padding: EdgeInsets.all(0),
        width: size.width,
        height: size.width * 0.2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(left: size.width / 4.8),
              width: size.width / 4,
              child: SvgPicture.asset('assets/images/knowledge.svg'),
            ),
            Text(
              'LUNA',
              style: TextStyle(
                  fontSize: 60,
                  color: Color(0xFF193566),
                  fontWeight: FontWeight.w300),
            )
          ],
        ),
      ),
    );
  }
}

// SvgPicture.asset(
//   assetName,
//   color: Colors.red,
//   semanticsLabel: 'A red up arrow'
// );

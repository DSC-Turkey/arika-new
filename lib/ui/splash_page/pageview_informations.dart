import 'package:arika/ui/auth/chose.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageViewInformations extends StatelessWidget {
  final String title;
  final String description;
  final String photo;
  final controller;
  final int index;

  PageViewInformations(
      {this.title, this.description, this.photo, this.controller, this.index});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        // size , x,y
        circle(size, -size.height * 0.1, -size.width * 0.1),
        circle(size * 2, -size.height * 0.1, size.width * 0.75),
        circle(size, size.height * 0.5, -size.width * 0.2),
        photoPart(size),
        content(size),
        //descriptionPart(size),
        //if (index == 2) signUpButton(context, size),
        //yanSayfayaGecme(size),
        signUpButton(context, size),
      ],
    );
  }

  circle(Size size, double x, double y) {
    return Positioned(
      top: x,
      left: y,
      child: Container(
        width: size.width * 0.4,
        height: size.width * 0.4,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
      ),
    );
  }

  photoPart(Size size) {
    return Positioned(
      top: size.height * 0.25,
      left: size.width * 0.15,
      child: Container(
        width: size.width * 0.6,
        height: size.width * 0.6,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        alignment: Alignment.center,
        child: Image.asset(
          photo,
          width: size.width * 0.45,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  content(Size size) {
    return Positioned(
      top: size.height * 0.65,
      left: size.width * 0.08,
      child: Container(
          width: size.width * 0.92,
          // alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // title
              Text(
                title,
                textAlign: TextAlign.left,
                softWrap: true,
                style: TextStyle(
                  fontSize: 22,
                  color: Color(0xFF1252C2),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // description
              Text(
                description,
                textAlign: TextAlign.left,
                softWrap: true,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          )),
    );
  }

  // descriptionPart(Size size) {
  //   return Positioned(
  //     top: size.height * 0.7,
  //     left: size.width * 0.1,
  //     child: Container(
  //       //padding: EdgeInsets.symmetric(horizontal: 20),
  //       width: size.width,
  //       alignment: Alignment.centerLeft,
  //       child: Text(
  //         description,
  //         textAlign: TextAlign.left,
  //         style: TextStyle(
  //             fontSize: 15,
  //             color: Color(0xff969AA8),
  //             fontWeight: FontWeight.bold,
  //             fontFamily: "PoppinsRegular"),
  //       ),
  //     ),
  //   );
  // }

  signUpButton(BuildContext context, Size size) {
    return Positioned(
      bottom: size.height * 0.05,
      right: size.width * 0.1,
      left: size.width * 0.1,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Chose(),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: size.height * 0.024),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xff707070), width: 0.2),
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue.shade800,
          ),
          alignment: Alignment.center,
          child: Text(
            "Kullanmaya Başla",
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

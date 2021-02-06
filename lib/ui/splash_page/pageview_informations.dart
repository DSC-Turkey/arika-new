import 'package:arika/ui/auth/sign_up.dart';
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
        photoPart(size),
        titlePart(size),
        descriptionPart(size),
        if (index == 2) signUpButton(context, size),
        //yanSayfayaGecme(size),
      ],
    );
  }

  photoPart(Size size) {
    return Positioned(
      top: size.height * 0.15,
      child: Container(
        width: size.width,
        alignment: Alignment.center,
        child: Image.asset(
          photo,
          width: size.width * 0.45,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  titlePart(Size size) {
    return Positioned(
      top: size.height * 0.45,
      child: Container(
        width: size.width,
        alignment: Alignment.center,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  descriptionPart(Size size) {
    return Positioned(
      top: size.height * 0.53,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: size.width,
        alignment: Alignment.center,
        child: Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 15,
              color: Color(0xff969AA8),
              fontWeight: FontWeight.bold,
              fontFamily: "PoppinsRegular"),
        ),
      ),
    );
  }

  signUpButton(BuildContext context, Size size) {
    return Positioned(
      bottom: size.height * 0.15,
      right: size.width * 0.1,
      left: size.width * 0.1,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SignUp(
                context: context,
              ),
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
            "Hesap Oluştur",
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

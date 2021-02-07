import 'package:arika/config/base/text_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';

class Sign extends StatefulWidget {
  final bool isTeacher;
  const Sign({Key key, this.isTeacher}) : super(key: key);
  @override
  _SignState createState() => _SignState(isTeacher: isTeacher);
}

class _SignState extends State<Sign> {
  final bool isTeacher;
  bool _isLogIn = true;
  _SignState({Key key, this.isTeacher});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          background(size, -size.height * 0.3, -size.width * 0.2),
          logo(size, size.height * 0.05, 0),
          card(size, size.height * 0.2, size.width * 0.1),
          image(size, size.height * 0.85, size.width * 0.5),
        ],
      ),
    );
  }

  background(Size size, double x, double y) {
    return Positioned(
      top: x,
      left: y,
      child: Container(
        width: size.width * 1.2,
        height: size.width * 1.2,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFFFFFF), Color(0xFF1252C2)],
          ),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  logo(Size size, double x, double y) {
    return Positioned(
      top: x,
      left: y,
      child: Container(
        width: size.width,
        height: size.height * 0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(right: 20),
              width: size.width / 6,
              child: SvgPicture.asset('assets/images/knowledge.svg'),
            ),
            Text(
              'LUNA',
              style: TextStyle(
                  fontSize: 40,
                  color: Color(0xFF193566),
                  fontWeight: FontWeight.w300),
            )
          ],
        ),
      ),
    );
  }

  image(Size size, double x, double y) {
    return Positioned(
      top: x,
      left: y,
      width: size.width * 0.5,
      height: size.height * 0.15,
      child: Image.asset('assets/images/school.jpg'),
    );
  }

  card(Size size, double x, double y) {
    return Positioned(
      top: x,
      left: y,
      width: size.width * 0.8,
      height: size.height * 0.65,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Column(
          children: [
            SizedBox(
              height: size.width * 0.05,
            ),
            FlutterToggleTab(
              width: size.width * 0.18,
              borderRadius: 30,
              height: size.height * 0.05,
              initialIndex: 0,
              isScroll: false,
              selectedBackgroundColors: [
                Color(0xFF193566),
              ],
              selectedTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
              unSelectedTextStyle: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
              labels: ["Log In", "Sign Up"],
              selectedLabelIndex: (index) {
                setState(() {
                  index == 0 ? _isLogIn = true : _isLogIn = false;
                });
              },
            ),
            logInSignUp(size,_isLogIn),
            // _isLogIn ? logIn(formKey) : signUp(),
          ],
        ),
      ),
    );
  }

  logInSignUp(size,isLogIn) {
    final formKey = GlobalKey<FormState>();
    String email, password;
    return Container(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            emailPart(size,email),
            // passwordPart(size),
            // forgotPasswordPart(size),
            // loginButton(size),
            // signUpButton(context, size),
          ],
        ),
      ),
    );
  }

  logIn(formKey) {
    return Container(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // emailPart(size),
            // passwordPart(size),
            // forgotPasswordPart(size),
            // loginButton(size),
            // signUpButton(context, size),
          ],
        ),
      ),
    );
  }

  signUp() {}

  emailPart(Size size,String email) {
    return Container(
      margin:
          EdgeInsets.only(top: size.height * 0.13, bottom: size.height * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: size.height * 0.01),
            child: Text(
              "Email",
              style: TextStyle(
                  color: Color(0xff969AA8),
                  fontSize: 15,
                  fontFamily: "PoppinsRegular"),
            ),
          ),
          TextArea(
            textInputType: TextInputType.emailAddress,
            obsecureText: false,
            onSaved: (gelenEmail) {
              email = gelenEmail;
            },
            validator: (gelenEmail) {
              if (gelenEmail.isEmpty) {
                return "Bu alan boş bırakılamaz";
              } else
                return null;
            },
            hintText: "Email",
          ),
        ],
      ),
    );
  }
}

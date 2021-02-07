import 'package:arika/config/base/text_area.dart';
import 'package:arika/ui/drive/orgin.dart';
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
          Positioned(
              top: size.height * 0.72,
              width: size.width,
              child: Center(
                  child: Text('Ya Da',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)))),
          fastLogIn(size, size.height * 0.77),
          submitButton(size, _isLogIn, isTeacher, size.height * 0.64),
          Positioned(child: goToDrive(),top: size.height*0.9,left: 0,)
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
            logInSignUp(size, _isLogIn),
          ],
        ),
      ),
    );
  }

  logInSignUp(size, isLogIn) {
    return Container(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLogIn == false) namePart(size),
            emailPart(size, isLogIn),
            passwordPart(size),
          ],
        ),
      ),
    );
  }

  submitButton(Size size, bool isLogIn, bool isTeacher, double x) {
    return Positioned(
      top: x,
      width: size.width,
      child: GestureDetector(
        onTap: () {
          submit(isLogIn, isTeacher);
        },
        child: Container(
          width: size.width * 0.6,
          height: size.height * 0.06,
          margin: EdgeInsets.only(
              left: size.width * 0.15, right: size.width * 0.15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Color(0xFF193566),
          ),
          alignment: Alignment.center,
          child: Text(
            isLogIn ? "Log In" : "Sign Up",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  namePart(Size size) {
    return Container(
      width: size.width * 0.7,
      padding: EdgeInsets.only(left: 10),
      margin: EdgeInsets.only(top: 40, left: 10, right: 10),
      decoration: BoxDecoration(
        color: Color(0xffe0e0e0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Adı Soyadı',
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (input) =>
              _userNameValidation(input) == false ? 'Hatalı Adı' : null,
          onSaved: (input) {
            _data['name'] = input;
          },
          onChanged: (input) {
            _data['name'] = input;
          }),
    );
  }

  bool _userNameValidation(String value) {
    String pattern = r'^[0-9a-zA-ZğüşöçıĞÜŞÖÇİ.]{6,15}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  emailPart(Size size, bool isLogIn) {
    return Container(
      width: size.width * 0.7,
      padding: EdgeInsets.only(left: 10),
      margin: EdgeInsets.only(top: isLogIn ? 40 : 10, left: 10, right: 10),
      decoration: BoxDecoration(
        color: Color(0xffe0e0e0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Email',
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (input) => !input.contains('@') ? 'Hatalı Email' : null,
          onSaved: (input) {
            _data['email'] = input;
          },
          onChanged: (input) {
            _data['email'] = input;
          }),
    );
  }

  passwordPart(Size size) {
    return Container(
      width: size.width * 0.7,
      padding: EdgeInsets.only(left: 10),
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      decoration: BoxDecoration(
        color: Color(0xffe0e0e0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Şifra',
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (input) =>
              _passwordValidation(input) == false ? 'hatalı Şifra' : null,
          onSaved: (input) {
            _data['password'] = input;
          },
          onChanged: (input) {
            _data['password'] = input;
          }),
    );
  }

  bool _passwordValidation(String value) {
    // Password must contain at least one uppercase character one lowercase character and one number and between 8-30
    String pattern = r'^(?=.*?[a-zA-Z0-9]).{8,30}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  fastLogIn(Size size, double x) {
    return Positioned(
      width: size.width,
      height: size.height * 0.05,
      top: x,
      child: Container(
        width: size.width / 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: GestureDetector(
                onTap: google,
                child: SvgPicture.asset('assets/images/google.svg'),
              ),
              width: 50,
            ),
            Container(
              width: 50,
              child: GestureDetector(
                onTap: twitter,
                child: SvgPicture.asset('assets/images/twitter.svg'),
              ),
            ),
            Container(
              width: 50,
              child: GestureDetector(
                onTap: facebook,
                child: SvgPicture.asset('assets/images/facebook.svg'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final formKey = GlobalKey<FormState>();
  Map _data = {'email': '', 'password': '', 'name': ''};
  String email, password;

  google() {}
  facebook() {}
  twitter() {}

  submit(isLogIn, isTeacher) {
    print('****************************************');
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      print(_data);
    }
  }

  goToDrive() {
    return RaisedButton.icon(
      label: Text('Go to Drive'),
      icon: Icon(Icons.run_circle_rounded),
      onPressed: () {
                  Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) =>Orgin(), //SignUp(context: context),
                ),
          );
        
      },
    );
  }
}

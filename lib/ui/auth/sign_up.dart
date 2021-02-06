import 'package:arika/config/base/close_keyboard.dart';
import 'package:arika/config/base/text_area.dart';
import 'package:arika/provider/auth_provider.dart';
import 'package:arika/ui/auth/login.dart';
import 'package:arika/ui/landing_page.dart';
import 'package:arika/utils/exception_handlers/auth_exception_handler.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  final BuildContext context;

  SignUp({this.context});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String email, password, name;
  bool _obscureText = true, _obscureText1 = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggle1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return KlavyeninKapanmasi(
      widget: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          resizeToAvoidBottomPadding: false,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Container(
                    width: size.width,
                    height: size.height,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          emailPart(size),
                          passwordPart(size),
                          namePart(size),
                          signUpButton(size),
                          loginButton(size, context)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Consumer<AuthProvider>(
                builder: (_, model, child) {
                  return model.isLoading
                      ? Container(
                          width: size.width,
                          height: size.height,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                          color: Colors.white.withOpacity(0.8),
                        )
                      : Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Container loginButton(Size size, BuildContext context) {
    return Container(
      width: size.width,
      margin: EdgeInsets.only(top: size.height * 0.14),
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
                text: "Hesabınız Var Mı ?",
                style: TextStyle(
                    color: Colors.black, fontFamily: "PoppinsRegular")),
            TextSpan(
                text: " Giriş Yap",
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Login(
                        context: context,
                      ),
                    ));
                  },
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: "PoppinsRegular")),
          ],
        ),
      ),
    );
  }

  emailPart(Size size) {
    return Container(
      margin:
          EdgeInsets.only(top: size.height * 0.02, bottom: size.height * 0.02),
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
              if (gelenEmail.isEmpty == true) {
                return "Lütfen bu alanı doldurunuz";
              } else if (!gelenEmail.contains("@")) {
                return "Lütfen geçerli bir email adresi giriniz";
              }
              return null;
            },
            hintText: "Email",
          ),
        ],
      ),
    );
  }

  passwordPart(Size size) {
    return Container(
      margin: EdgeInsets.only(bottom: size.height * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: size.height * 0.01),
            child: Text(
              "Şifre",
              style: TextStyle(
                  color: Color(0xff969AA8),
                  fontSize: 15,
                  fontFamily: "PoppinsRegular"),
            ),
          ),
          TextArea(
            maxLines: 1,
            obsecureText: _obscureText,
            onSaved: (gelenSifre) {
              password = gelenSifre;
            },
            validator: (gelenSifre) {
              if (gelenSifre.length < 8) {
                return "En az 8 karakter giriniz";
              } else {
                return null;
              }
            },
            suffixIcon: GestureDetector(
              onTap: () {
                _toggle();
              },
              child: Icon(
                Icons.visibility,
                color: Colors.blue.shade800,
              ),
            ),
            hintText: "Şifre",
          ),
        ],
      ),
    );
  }

  namePart(Size size) {
    return Container(
      margin: EdgeInsets.only(bottom: size.height * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: size.height * 0.01),
            child: Text(
              "Ad Soyad",
              style: TextStyle(
                  color: Color(0xff969AA8),
                  fontSize: 15,
                  fontFamily: "PoppinsRegular"),
            ),
          ),
          TextArea(
            maxLines: 1,
            obsecureText: _obscureText1,
            onSaved: (gelenSifre) {
              name = gelenSifre;
            },
            validator: (gelenSifre) {
              if (gelenSifre.length < 8) {
                return "En az 8 karakter giriniz";
              } else {
                return null;
              }
            },
            suffixIcon: GestureDetector(
              onTap: () {
                _toggle1();
              },
              child: Icon(
                Icons.visibility,
                color: Colors.blue.shade800,
              ),
            ),
            hintText: "Şifre Tekrar ",
          ),
        ],
      ),
    );
  }

  showAlertDialog(String error) {
    showDialog(
      context: widget.context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(error),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Kapat",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ))
          ],
        );
      },
    );
  }

  signUpButton(Size size) {
    final _authProvider = Provider.of<AuthProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          _authProvider
              .signUp(name: name, email: email, password: password)
              .then((value) {
            if (value != AuthResultStatus.successful) {
              final errorMsg =
                  AuthExceptionHandler.generateExceptionMessage(value);
              showAlertDialog(errorMsg);
            } else {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LandingPage()),
                  (route) => false);
            }
          });
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: size.height * 0.024),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xff707070), width: 0.1),
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue.shade800,
        ),
        alignment: Alignment.center,
        width: size.width,
        child: Text(
          "Üye Ol",
          style: TextStyle(
              color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

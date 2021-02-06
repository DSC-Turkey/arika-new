import 'package:arika/common_widgets/ekran_dokunma_klavye_kapanma.dart';
import 'package:arika/common_widgets/text_alani.dart';
import 'package:arika/exception_handlers/auth_exception_handler.dart';
import 'package:arika/landing_page.dart';
import 'package:arika/login_pages/forgot_password_page.dart';
import 'package:arika/login_pages/sign_up.dart';
import 'package:arika/provider/auth_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  final BuildContext context;

  Login({this.context});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String email, password;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: KlavyeninKapanmasi(
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
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.05),
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
                            forgotPasswordPart(size),
                            loginButton(size),
                            signUpButton(context, size),
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
      ),
    );
  }

  GestureDetector signUpButton(BuildContext context, Size size) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SignUp(
                  context: context,
                )));
      },
      child: Container(
        width: size.width,
        margin: EdgeInsets.only(top: size.height * 0.12),
        alignment: Alignment.center,
        child: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: "Hesabın Yok Mu ?",
                  style: TextStyle(
                      color: Colors.black, fontFamily: "PoppinsRegular")),
              TextSpan(
                  text: " Üye Ol",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SignUp(
                                context: context,
                              )));
                    },
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: "PoppinsRegular")),
            ],
          ),
        ),
      ),
    );
  }

  emailPart(Size size) {
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
              if (gelenSifre.isEmpty) {
                return "Bu alan boş bırakılamaz";
              } else
                return null;
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

  forgotPasswordPart(Size size) {
    return Container(
      margin: EdgeInsets.only(bottom: size.height * 0.03),
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ForgotPassword()));
        },
        child: Material(
          color: Colors.transparent,
          child: Container(
            child: Text(
              "Şifremi Unuttum?",
              style: TextStyle(
                  color: Colors.blue.shade800,
                  fontFamily: "PoppinsRegular",
                  fontSize: size.height * 0.02),
            ),
          ),
        ),
      ),
    );
  }

  loginButton(Size size) {
    return GestureDetector(
      onTap: () {
        girisYap();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: size.height * 0.024),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xff707070), width: 0.1),
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue.shade800,
        ),
        alignment: Alignment.center,
        child: Text(
          "Giriş Yap",
          style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.bold,
              fontFamily: "PoppinsMedium"),
        ),
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

  void girisYap() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      await authProvider.login(email: email, password: password).then((value) {
        if (value != AuthResultStatus.successful) {
          final errorMsg = AuthExceptionHandler.generateExceptionMessage(value);
          showAlertDialog(errorMsg);
        } else {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LandingPage()),
              (route) => false);
        }
      });
    } else {}
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}

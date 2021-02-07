import 'package:arika/provider/auth_provider.dart';
import 'package:arika/provider/user_provider.dart';
import 'package:arika/ui/about_page.dart';
import 'package:arika/ui/drive/moneyBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerScreen extends StatefulWidget {
  final String name;

  const DrawerScreen({Key key, this.name}) : super(key: key);
  @override
  _DrawerScreenState createState() => _DrawerScreenState(name: name);
}

class _DrawerScreenState extends State<DrawerScreen> {
  final String name;
  _DrawerScreenState({Key key, this.name});

  @override
  Widget build(BuildContext context) {
    final _userProvider = Provider.of<UserProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1252C2), Color(0xFFFFFFFF)],
        ),
      ),
      padding: EdgeInsets.only(top: 100, bottom: 70, left: 40),
      child: _userProvider.user != null
          ? SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/user.svg',
                        height: 40,
                        width: 40,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(_userProvider.user.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Container(
                    width: size.width * 0.5,
                    height: size.height * 0.66,
                    margin: EdgeInsets.only(left: 20, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //myRow('assets/images/user.svg', 'Profilim', classes),
                        myRow('assets/images/moneybox.svg', 'Kumbaram', math),
                        myRow('assets/images/aboutUs.svg', 'Hakkında', english),
                        myRow(
                          'assets/images/contact.svg',
                          'İletişim',
                          reading,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: logOut,
                    child: Text(
                      'Çıkış yap',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            )
          : Container(),
    );
  }

  myRow(String imagePath, String name, Function f) {
    return GestureDetector(
      onTap: f,
      child: Container(
        padding: EdgeInsets.only(left: 0),
        margin: EdgeInsets.only(
          top: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              imagePath,
              height: 30,
              width: 30,
              color: Colors.white,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              name,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  logOut() async {
    final _authProvider = Provider.of<AuthProvider>(context, listen: false);
    await _authProvider.signOut();
  }

  settings() {}
  classes() {}
  math() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => MoneyBox()));
  }

  english() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => About()));
  }

  reading() {
    launch('mailto:nadar909@outlook.com?subject=%20&body=%20');
  }
}

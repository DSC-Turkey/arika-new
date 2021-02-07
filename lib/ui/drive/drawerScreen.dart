import 'package:arika/ui/drive/aboutUs.dart';
import 'package:arika/ui/drive/moneyBox.dart';
import 'package:arika/ui/drive/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1252C2), Color(0xFFFFFFFF)],
        ),
      ),
      padding: EdgeInsets.only(top: 50, bottom: 70, left: 40),
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
                color: Color(0xFF193566),
              ),
              SizedBox(
                width: 10,
              ),
              Text('$name Name',
                  style: TextStyle(
                      color: Color(0xFF193566), fontWeight: FontWeight.bold)),
            ],
          ),
          Container(
            width: size.width * 0.5,
            height: size.height * 0.7,
            margin: EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                myRow('assets/images/profile.svg', 'Profil', profile),
                myRow('assets/images/moneybox.svg', 'Kumbara', moneyBox),
                myRow('assets/images/aboutUs.svg', 'Hakkımızda', aboutUs),
                myRow('assets/images/contact.svg', 'İletişim', contact),
              ],
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.settings,
                color: Color(0xFF193566),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: settings,
                child: Text(
                  'Settings',
                  style: TextStyle(
                      color: Color(0xFF193566), fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 2,
                height: 20,
                color: Color(0xFF193566),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: logOut,
                child: Text(
                  'Log out',
                  style: TextStyle(
                      color: Color(0xFF193566), fontWeight: FontWeight.bold),
                ),
              )
            ],
          )
        ],
      ),
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
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  logOut() {}
  settings() {}

  profile() {
    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (context) => Profile()));
  }

  moneyBox() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => MoneyBox()));
  }

  aboutUs() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AboutUs()));
  }

  contact() {}
}

<<<<<<< HEAD
import 'package:arika/ui/pay.dart';
import 'package:flutter/material.dart';
=======
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
>>>>>>> master/master

class MoneyBox extends StatefulWidget {
  @override
  _MoneyBoxState createState() => _MoneyBoxState();
}

class _MoneyBoxState extends State<MoneyBox> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
<<<<<<< HEAD
      appBar: AppBar(
        backgroundColor: Color(0xFF1252C2),
        elevation: 0,
        title: Text(""),
      ),
=======
>>>>>>> master/master
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
              width: size.width,
              child: Image.asset('assets/images/kumbaram.png'),
            ),
            Container(
              child: Center(
                child: Text(
<<<<<<< HEAD
                  'Eğitim ihtiyacı olan çocuklar için bağış yapmak istemez misiniz?',
=======
                  'vaervaervaervjkarbvbrivbaebrv;abure;vba;eruvb',
>>>>>>> master/master
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: Container(
                child: GestureDetector(
                  onTap: donat,
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
                      "Bağış",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

<<<<<<< HEAD
  donat() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Pay()));
  }
=======
  donat() {}
>>>>>>> master/master
}

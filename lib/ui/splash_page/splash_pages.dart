import 'package:arika/ui/auth/login.dart';
import 'package:arika/ui/splash_page/pageview_informations.dart';
import 'package:flutter/material.dart';

class SplashPages extends StatefulWidget {
  @override
  _SplashPagesState createState() => _SplashPagesState();
}

class _SplashPagesState extends State<SplashPages> {
  int _currentPage = 0;
  static PageController _controller = PageController(initialPage: 0);

  List<Widget> _pages = [
    PageViewInformations(
      title: "Öğretmenler bla bla",
      description:
          "Öğretmen olarak kayıt olup öğrencilere ders videosu hazırlayıp aynı zamanda para kazanabilirsiniz",
      photo: "assets/images/splash_photo.png",
      controller: _controller,
      index: 0,
    ),
    PageViewInformations(
      title: "Öğrenciler bla bla",
      description:
          "Öğrenci olarak tüm öğretmenlerin dersinden ücretsiz faydalanabilirsiniz",
      photo: "assets/images/splash_photo1.png",
      controller: _controller,
      index: 1,
    ),
    PageViewInformations(
      title: "Uygulama hakkında bilgi bla bla",
      description:
          "Uygulamamızda aynı zamanda öğrencilerin satış gerçekleştirdiği bir bölüm bulunmaktadır",
      photo: "assets/images/splash_photo2.png",
      controller: _controller,
      index: 2,
    ),
  ];

  _onchanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            scrollDirection: Axis.horizontal,
            onPageChanged: _onchanged,
            controller: _controller,
            itemCount: _pages.length,
            itemBuilder: (context, int index) {
              return _pages[index];
            },
          ),
          animationContainer(size),
          loginButton(size),
        ],
      ),
    );
  }

  Positioned animationContainer(Size size) {
    return Positioned(
      bottom: size.height * 0.28,
      child: Container(
        width: size.width,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(_pages.length, (int index) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: 5,
                  width: (index == _currentPage) ? 20 : 10,
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: (index == _currentPage)
                          ? Colors.blue
                          : Colors.blue.withOpacity(0.3)),
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  Positioned loginButton(Size size) {
    return Positioned(
      bottom: size.height * 0.066,
      child: Container(
        width: size.width,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hesabım Var",
              style: TextStyle(
                color: Color(0xff969AA8),
                fontWeight: FontWeight.bold,
                fontSize: 15,
                fontFamily: "PoppinsRegular",
              ),
            ),
            SizedBox(
              width: 7,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Login(
                          context: context,
                        )));
              },
              child: Text(
                "Giriş Yap",
                style: TextStyle(
                  color: Colors.blue.shade800,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  fontFamily: "PoppinsRegular",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

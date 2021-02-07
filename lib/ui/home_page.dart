import 'package:arika/provider/data_provider.dart';
import 'package:arika/provider/user_provider.dart';
import 'package:arika/ui/add_lesson.dart';
import 'package:arika/ui/drive/moneyBox.dart';
import 'package:arika/ui/lessons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    final _userProvider = Provider.of<UserProvider>(context, listen: false);
    final _dataProvider = Provider.of<DataProvider>(context, listen: false);
    _dataProvider.getCategories();
    _userProvider.currentUser();
  }

  List<SvgPicture> images = [
    SvgPicture.asset(
      "assets/images/book.svg",
      width: 25,
      height: 25,
    ),
    SvgPicture.asset(
      "assets/images/addition.svg",
      width: 25,
      height: 25,
    ),
    SvgPicture.asset(
      "assets/images/english.svg",
      width: 25,
      height: 25,
    ),
  ];

  int _currentIndex;
  int _currentIndex1;
  int _currentIndex2;

  String lessonIndex;
  String subjectIndex;
  String classIndex;

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;
  Color primaryGreen = Colors.red;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final _dataProvider = Provider.of<DataProvider>(context);
    final _userProvider = Provider.of<UserProvider>(context);
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor)
        ..rotateY(isDrawerOpen ? -0.5 : 0),
      duration: Duration(milliseconds: 250),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0)),
      child: Scaffold(
        backgroundColor: Color(0xfff1f1f1),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color(0xff4c6287)),
          title: Text(""),
          backgroundColor: Color(0xfff1f1f1),
          elevation: 0,
          actions: [
            drawerPart(size),
            Padding(
              padding: EdgeInsets.only(right: size.width * 0.08),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MoneyBox()));
                },
                child: SvgPicture.asset(
                  "assets/images/moneybox.svg",
                  height: size.height * 0.03,
                ),
              ),
            ),
          ],
        ),
        body: _userProvider.user != null
            ? SingleChildScrollView(
                child: Consumer<DataProvider>(
                  builder: (context, snapshot, w) {
                    if (snapshot.categoryList != null) {
                      return Container(
                        margin: EdgeInsets.only(
                          top: size.height * 0.04,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            searchBar(size),
                            Container(
                              margin: EdgeInsets.only(
                                left: size.width * 0.08,
                                right: size.width * 0.08,
                              ),
                              child: Text(
                                "Dersler",
                                style: TextStyle(
                                    fontSize: 15, color: Color(0xff26406e)),
                              ),
                            ),
                            lessons(size, snapshot, _dataProvider),
                            Container(
                              margin: EdgeInsets.only(
                                  left: size.width * 0.08,
                                  right: size.width * 0.08,
                                  top: size.height * 0.04),
                              child: Text(
                                "Sınıf Seçiniz",
                                style: TextStyle(
                                    fontSize: 15, color: Color(0xff26406e)),
                              ),
                            ),
                            classes(size, snapshot, _dataProvider),
                            Container(
                              margin: EdgeInsets.only(
                                  left: size.width * 0.08,
                                  right: size.width * 0.08,
                                  top: size.height * 0.04),
                              child: Text(
                                "Ders İçerikleri",
                                style: TextStyle(
                                    fontSize: 15, color: Color(0xff26406e)),
                              ),
                            ),
                            _currentIndex1 != null
                                ? subjects(size, snapshot)
                                : Container(),
                            if (_userProvider.user.who == false)
                              showLessons(context, snapshot, size),
                            if (_userProvider.user.who == true)
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.08),
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    showLessonsForTeacher(
                                        context, snapshot, size),
                                    addLessons(context, size)
                                  ],
                                ),
                              )
                          ],
                        ),
                      );
                    } else
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                  },
                ),
              )
            : Container(),
      ),
    );
  }

  Padding drawerPart(Size size) {
    return Padding(
      padding: EdgeInsets.only(right: size.width * 0.7),
      child: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            if (isDrawerOpen == false) {
              setState(() {
                xOffset = 230;
                yOffset = 150;
                scaleFactor = 0.6;
                isDrawerOpen = true;
              });
            } else {
              setState(() {
                xOffset = 0;
                yOffset = 0;
                scaleFactor = 1;
                isDrawerOpen = false;
              });
            }
          }),
    );
  }

  GestureDetector showLessonsForTeacher(
      BuildContext context, DataProvider snapshot, Size size) {
    return GestureDetector(
      onTap: () {
        if (_currentIndex != null &&
            _currentIndex1 != null &&
            _currentIndex2 != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Lessons(
                subjectId: subjectIndex,
                categoryId: lessonIndex,
                classId: classIndex,
                categoryName: snapshot.categoryList[_currentIndex].name,
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Lütfen İçerik Seçiniz")));
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff193566),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        width: size.width * 0.35,
        height: size.height * 0.06,
        margin: EdgeInsets.only(
          top: size.height * 0.05,
        ),
        child: Text(
          "Dersleri İncele",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }

  GestureDetector addLessons(BuildContext context, Size size) {
    return GestureDetector(
      onTap: () {
        if (_currentIndex != null &&
            _currentIndex1 != null &&
            _currentIndex2 != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddLesson(
                lessonIndex: lessonIndex,
                classIndex: classIndex,
                subjectIndex: subjectIndex,
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Lütfen içerik seçiniz")));
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff193566),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        width: size.width * 0.35,
        height: size.height * 0.06,
        margin: EdgeInsets.only(
          top: size.height * 0.05,
        ),
        child: Text(
          "Ders Ekle",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }

  GestureDetector showLessons(
      BuildContext context, DataProvider snapshot, Size size) {
    return GestureDetector(
      onTap: () {
        if (_currentIndex != null &&
            _currentIndex1 != null &&
            _currentIndex2 != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Lessons(
                subjectId: subjectIndex,
                categoryId: lessonIndex,
                classId: classIndex,
                categoryName: snapshot.categoryList[_currentIndex].name,
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Lütfen İçerik Seçiniz")));
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff193566),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        width: size.width * 0.5,
        height: size.height * 0.06,
        margin: EdgeInsets.only(
          top: size.height * 0.05,
          left: size.width * 0.25,
        ),
        child: Text(
          "Dersleri İncele",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }

  Container subjects(Size size, DataProvider snapshot) {
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.02),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            snapshot.subjectList.length,
            (index) {
              if (snapshot.subjectList.length != 0) {
                return GestureDetector(
                  onTap: () {
                    subjectIndex = snapshot.subjectList[index].id;
                    setState(() {
                      _currentIndex2 = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      left: size.width * 0.08,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: _currentIndex2 != index
                              ? Colors.grey.shade300
                              : Color(0xff26406e)),
                    ),
                    height: size.height * 0.11,
                    width: size.width * 0.327,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          snapshot.subjectList[index].name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: size.height * 0.02,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else
                return Text("Henüz bu alana bir ders eklenmemiş");
            },
          ),
        ),
      ),
    );
  }

  classes(Size size, DataProvider snapshot, DataProvider _dataProvider) {
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.02),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            snapshot.classList.length,
            (index) => GestureDetector(
              onTap: () async {
                await _dataProvider
                    .getSubjects(lessonIndex, snapshot.classList[index].grade)
                    .then((value) {});
                setState(() {
                  classIndex = snapshot.classList[index].grade;
                  _currentIndex1 = index;
                });
              },
              child: Container(
                margin: EdgeInsets.only(
                  left: size.width * 0.08,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: _currentIndex1 != index
                          ? Colors.grey.shade300
                          : Color(0xff26406e)),
                ),
                height: size.height * 0.11,
                width: size.width * 0.327,
                child: Center(
                  child: Text(
                    snapshot.classList[index].grade + ".sınıf",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: size.height * 0.02,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  lessons(Size size, DataProvider snapshot, DataProvider _dataProvider) {
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.02),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            snapshot.categoryList.length,
            (index) => GestureDetector(
              onTap: () async {
                await _dataProvider
                    .getClass(snapshot.categoryList[index].id)
                    .then((value) {});
                setState(() {
                  _currentIndex1 = null;
                  _currentIndex2 = null;
                  _currentIndex = index;
                  lessonIndex = snapshot.categoryList[index].id;
                });
              },
              child: Container(
                margin: EdgeInsets.only(
                  left: size.width * 0.08,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: _currentIndex != index
                          ? Colors.grey.shade300
                          : Color(0xff26406e)),
                ),
                height: size.height * 0.11,
                width: size.width * 0.327,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    images[index],
                    Text(
                      snapshot.categoryList[index].name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: size.height * 0.02,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container searchBar(Size size) {
    return Container(
      height: size.height * 0.07,
      margin: EdgeInsets.only(
          left: size.width * 0.08,
          right: size.width * 0.08,
          bottom: size.height * 0.04),
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: size.height * 0.012,
            horizontal: size.width * 0.06,
          ),
          hintText: "Arama (Yakında Aktif Olacaktır)",
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
    );
  }
}

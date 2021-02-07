import 'package:arika/model/teacher_model.dart';
import 'package:arika/provider/data_provider.dart';
import 'package:arika/provider/user_provider.dart';
import 'package:arika/ui/video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Lessons extends StatefulWidget {
  final subjectId;
  final categoryId;
  final classId;
  final categoryName;

  Lessons(
      {Key key,
      this.subjectId,
      this.categoryId,
      this.classId,
      this.categoryName})
      : super(key: key);

  @override
  _LessonsState createState() => _LessonsState();
}

class _LessonsState extends State<Lessons> {
  @override
  Widget build(BuildContext context) {
    final _dataProvider = Provider.of<DataProvider>(context);
    final _userProvider = Provider.of<UserProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(""),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        margin: EdgeInsets.only(
          top: size.height * 0.02,
          left: size.width * 0.06,
          right: size.width * 0.06,
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: size.height * 0.07),
              child: Text(
                widget.classId +
                    ".sınıf ${widget.categoryName}\n Ders Videoları",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder<List<TeacherModel>>(
                future: _dataProvider.getTeachers(
                  widget.subjectId,
                  widget.categoryId,
                  widget.classId,
                  _userProvider.user,
                ),
                builder: (context, snapshot1) {
                  if (snapshot1.data != null) {
                    if (snapshot1.data.length > 0) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot1.data.length,
                        itemBuilder: (context1, index1) => Container(
                          height: size.height * 0.15,
                          margin: EdgeInsets.only(bottom: size.width * 0.15),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => Video(
                                        url: snapshot1.data[index1].url,
                                      ),
                                    ),
                                  );
                                },
                                child: Icon(
                                  Icons.play_circle_fill,
                                  color: Color(0xff193566),
                                  size: 34,
                                ),
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xff193566),
                                      borderRadius: BorderRadius.circular(20)),
                                  width: size.width * 0.3,
                                  height: size.height * 0.15,
                                  margin: EdgeInsets.only(
                                      right: size.width * 0.07,
                                      left: size.width * 0.05),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      "assets/images/knowledge.svg",
                                      width: size.width * 0.2,
                                      color: Colors.white,
                                    ),
                                  )),
                              SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Ders Videosu ${index1 + 1}",
                                      style: TextStyle(
                                          color: Color(0xff193566),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.013,
                                    ),
                                    Text(
                                      "Eğitmen :",
                                      style: TextStyle(
                                          color: Color(0xff193566),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    Text(
                                      "${snapshot1.data[index1].name}",
                                    ),
                                    SizedBox(
                                      height: size.height * 0.013,
                                    ),
                                    Text(
                                      "Açıklaması :",
                                      style: TextStyle(
                                          color: Color(0xff193566),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    Text(
                                      snapshot1.data[index1].description,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    } else
                      return Container(
                        margin: EdgeInsets.only(top: size.height * 0.2),
                        child: Center(
                          child: Text(
                            "Bu konu için henüz\n video oluşturulmamış",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      );
                  } else
                    return Container();
                }),
          ],
        ),
      ),
    );
  }
}

import 'package:arika/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddLesson extends StatefulWidget {
  final lessonIndex;
  final classIndex;
  final subjectIndex;

  AddLesson({this.lessonIndex, this.classIndex, this.subjectIndex});

  @override
  _AddLessonState createState() => _AddLessonState();
}

class _AddLessonState extends State<AddLesson> {
  var file;

  bool video = false;
  final _formKey = GlobalKey<FormState>();
  String description;

  @override
  Widget build(BuildContext context) {
    final _userProvider = Provider.of<UserProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text(""),
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Container(
          margin: EdgeInsets.only(
            right: size.width * 0.06,
            left: size.width * 0.06,
          ),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: size.height * 0.04),
                      child: Text(
                        "Lütfen Video Yükleyin",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color(0xff193566),
                        ),
                      ),
                    ),
                    Container(
                      height: size.height * 0.25,
                      width: size.width,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              width: 1, color: Colors.blue.shade800)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset(
                            "assets/images/direct-download.svg",
                            width: size.width * 0.05,
                            height: size.height * 0.05,
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (video == false) {
                                file = await ImagePicker()
                                    .getVideo(source: ImageSource.gallery)
                                    .whenComplete(() {
                                  setState(() {
                                    video = true;
                                  });
                                });
                              } else {}
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xff193566),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.04,
                                  vertical: size.height * 0.01,
                                ),
                                child: Text(
                                  video == false
                                      ? "Dosya Seç"
                                      : "Dosya Yüklendi",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Container(
                        margin: EdgeInsets.only(top: size.height * 0.05),
                        child: TextFormField(
                          onSaved: (value) {
                            description = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Lütfen bu alanı doldurunuz";
                            } else
                              return null;
                          },
                          maxLength: 30,
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: "Açıklama",
                            contentPadding: EdgeInsets.symmetric(
                              vertical: size.height * 0.025,
                              horizontal: size.width * 0.03,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState.validate() &&
                                file != null) {
                              _formKey.currentState.save();
                              await _userProvider
                                  .uploadVideo(
                                      workIndex: widget.lessonIndex,
                                      description: description,
                                      classIndex: widget.classIndex,
                                      subjectIndex: widget.subjectIndex,
                                      file: file,
                                      comeUser: _userProvider.user)
                                  .then((value) {
                                if (value != UserStatus.SUCCESS) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(value)));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text("İşlem Başarılı")));
                                  Navigator.of(context).pop();
                                }
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "Lütfen boş alanları doldurunuz")));
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xff193566),
                                borderRadius: BorderRadius.circular(20)),
                            margin: EdgeInsets.only(top: size.height * 0.05),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: size.height * 0.015,
                                  horizontal: size.width * 0.09),
                              child: Text(
                                "Yükle",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 17),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Text(
                          "Bu işlem bir kaç dakikanızı alabilir",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                Consumer<UserProvider>(
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
}

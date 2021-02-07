import 'package:arika/model/subject_model.dart';
import 'package:arika/model/teacher_model.dart';
import 'package:arika/provider/data_provider.dart';
import 'package:arika/provider/user_provider.dart';
import 'package:arika/ui/video.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubjectsPage extends StatefulWidget {
  final categoryID;
  final classID;

  SubjectsPage({this.categoryID, this.classID});

  @override
  _SubjectsPageState createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  List<SubjectModel> liste = [];
  List<TeacherModel> liste1 = [];

  QuerySnapshot querySnapshot;

  @override
  void initState() {
    super.initState();
    final _dataProvider = Provider.of<DataProvider>(context, listen: false);
    _dataProvider.getSubjects(widget.categoryID, widget.classID);
  }

  @override
  Widget build(BuildContext context) {
    final _dataProvider = Provider.of<DataProvider>(context);
    final _userProvider = Provider.of<UserProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: Consumer<DataProvider>(builder: (context, snapshot, w) {
          if (snapshot.subjectList.length > 0) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.subjectList.length,
              itemBuilder: (context, index) => ExpansionTile(
                title: Text(
                  snapshot.subjectList[index].name,
                  style: TextStyle(color: Colors.black),
                ),
                children: [
                  FutureBuilder(
                      future: _dataProvider.getTeachers(
                        snapshot.subjectList[index].id,
                        widget.categoryID,
                        widget.classID,
                        _userProvider.user,
                      ),
                      builder: (context, snapshot1) {
                        print(snapshot1.data.length.toString());
                        if (snapshot1.data.length != null) {
                          return Container(
                            width: 1000,
                            height: 300,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot1.data.length,
                              itemBuilder: (context1, index1) =>
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
                                child: Container(
                                  width: 400,
                                  height: 150,
                                  child: Row(
                                    children: [
                                      Text(
                                        snapshot1.data[index1].name,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      Text(
                                        snapshot1.data[index1].description,
                                        style: TextStyle(color: Colors.black),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else
                          return Container();
                      })
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }

  Future konulariGetir() async {
    /*
    querySnapshot = await widget.data.collection("subjects${widget.id}").get();
    for (var item in querySnapshot.docs) {
      liste.add(SubjectModel.fromMap(item.data()));
    }
     */
  }

  Future<List<TeacherModel>> getTeachers() async {
    /*
    var snapshot = await widget.data
        .collection("subjects${widget.id}")
        .doc("üslü sayılar")
        .collection("teachers")
        .get();
    for (var item in snapshot.docs) {
      liste1.add(TeacherModel.fromMap(item.data()));
    }
    return liste1;
     */
  }
}

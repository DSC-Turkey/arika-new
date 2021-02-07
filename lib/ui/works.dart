import 'package:arika/model/category_model.dart';
import 'package:arika/provider/data_provider.dart';
import 'package:arika/ui/subjects_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Works extends StatefulWidget {
  @override
  _WorksState createState() => _WorksState();
}

class _WorksState extends State<Works> {
  List<CategoryModel> liste = [];

  QuerySnapshot querySnapshot;

  @override
  void initState() {
    super.initState();
    final _dataProvider = Provider.of<DataProvider>(context, listen: false);
    _dataProvider.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    final _dataProvider = Provider.of<DataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Konular"),
      ),
      body: Consumer<DataProvider>(builder: (context, snapshot, w) {
        if (snapshot.categoryList.length > 0) {
          return Container(
            child: ListView.builder(
              itemCount: snapshot.categoryList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () async {
                    await _dataProvider
                        .getClass(snapshot.categoryList[index].id);
                    showdialog();
                  },
                  title: Text(snapshot.categoryList[index].name),
                );
              },
            ),
          );
        } else
          return Center(
            child: CircularProgressIndicator(),
          );
      }),
    );
  }

  dersleriGetir() async {
    querySnapshot =
        await FirebaseFirestore.instance.collection("categories").get();
    for (var item in querySnapshot.docs) {
      liste.add(CategoryModel.fromMap(item.data()));
    }
  }

  showdialog() {
    //final _userModel = Provider.of<UserModel>(context, listen: false);
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) => Container(
              height: 100,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                content: Builder(
                  builder: (context) =>
                      Consumer<DataProvider>(builder: (context, snapshot, w) {
                    if (snapshot.classList.length > 0) {
                      return Container(
                        width: 300,
                        height: 200,
                        child: ListView.builder(
                            itemCount: snapshot.classList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 50,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => SubjectsPage(
                                          categoryID: snapshot
                                              .classList[index].categoryID,
                                          classID:
                                              snapshot.classList[index].grade,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(snapshot.classList[index].grade +
                                      ".sınıf"),
                                ),
                              );
                            }),
                      );
                    } else
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                  }),
                ),
              ),
            ),
          );
        });
  }
}

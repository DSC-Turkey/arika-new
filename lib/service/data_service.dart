import 'package:arika/model/category_model.dart';
import 'package:arika/model/class_model.dart';
import 'package:arika/model/subject_model.dart';
import 'package:arika/model/teacher_model.dart';
import 'package:arika/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataService {
  final FirebaseFirestore _dbService = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getCategories() async {
    List<CategoryModel> categoryList = [];
    QuerySnapshot querySnapshot =
        await _dbService.collection("categories").get();
    for (var item in querySnapshot.docs) {
      categoryList.add(CategoryModel.fromMap(item.data()));
    }
    return categoryList;
  }

  Future<List<SubjectModel>> getSubjects(categoryID, classID) async {
    List<SubjectModel> subjectsLists = [];
    QuerySnapshot querySnapshot = await _dbService
        .collection("subjects")
        .where("categoryId", isEqualTo: categoryID)
        .where("classId", arrayContains: classID)
        .get();
    for (var item in querySnapshot.docs) {
      subjectsLists.add(SubjectModel.fromMap(item.data()));
    }
    return subjectsLists;
  }

  Future<List<ClassModel>> getClass(String id) async {
    List<ClassModel> subjectsLists = [];
    QuerySnapshot querySnapshot = await _dbService
        .collection("classes")
        .where("categoryID", isEqualTo: "1")
        .get();
    for (var item in querySnapshot.docs) {
      subjectsLists.add(ClassModel.fromMap(item.data()));
    }
    return subjectsLists;
  }

  Future<List<TeacherModel>> getTeachers(
      subjectID, categoryID, classID, UserModel comeUser) async {
    List<TeacherModel> teacherLists = [];
    QuerySnapshot querySnapshot = await _dbService
        .collection("teachers")
        .where(
          "categoryId",
          isEqualTo: categoryID,
        )
        .where(
          "classId",
          isEqualTo: classID,
        )
        .where("subjectId", isEqualTo: subjectID)
        .get();
    for (var item in querySnapshot.docs) {
      teacherLists.add(TeacherModel.fromMap(item.data()));
    }
    return teacherLists;
  }
}

import 'package:arika/model/category_model.dart';
import 'package:arika/model/class_model.dart';
import 'package:arika/model/subject_model.dart';
import 'package:arika/model/teacher_model.dart';
import 'package:arika/model/user_model.dart';
import 'package:arika/repository/user_repository.dart';
import 'package:arika/service/locator.dart';
import 'package:flutter/material.dart';

enum DataStatus { SUCCESS }

class DataProvider with ChangeNotifier {
  UserRepository _userRepository = locator<UserRepository>();

  DataStatus _dataStatus = DataStatus.SUCCESS;

  bool isLoading = false;

  changeState(bool _isLoading) {
    isLoading = _isLoading;
    notifyListeners();
  }

  List<CategoryModel> _categoryList = [];
  List<SubjectModel> _subjectList = [];
  List<ClassModel> _classList = [];
  List<TeacherModel> _teacherList = [];

  List<TeacherModel> get teacherList => _teacherList;

  set teacherList(List<TeacherModel> value) {
    _teacherList = value;
  }

  List<ClassModel> get classList => _classList;

  set classList(List<ClassModel> value) {
    _classList = value;
    notifyListeners();
  }

  List<SubjectModel> get subjectList => _subjectList;

  set subjectList(List<SubjectModel> value) {
    _subjectList = value;
    notifyListeners();
  }

  List<CategoryModel> get categoryList => _categoryList;

  set categoryList(List<CategoryModel> value) {
    _categoryList = value;
  }

  Future getCategories() async {
    try {
      categoryList = null;
      List<CategoryModel> comeList = await _userRepository.getCategories();
      _categoryList = comeList;
      notifyListeners();
      _dataStatus = DataStatus.SUCCESS;
    } catch (e) {
      _dataStatus = e;
    }
    return _dataStatus;
  }

  Future getSubjects(categoryID, classID) async {
    try {
      List<SubjectModel> comeList =
          await _userRepository.getSubjects(categoryID, classID);
      _subjectList = comeList;
      notifyListeners();
      _dataStatus = DataStatus.SUCCESS;
    } catch (e) {
      _dataStatus = e;
    }
    return _dataStatus;
  }

  Future getClass(String id) async {
    try {
      List<ClassModel> comeList = await _userRepository.getClass(id);
      _classList = comeList;
      notifyListeners();
      _dataStatus = DataStatus.SUCCESS;
    } catch (e) {
      _dataStatus = e;
    }
    return _dataStatus;
  }

  Future<List<TeacherModel>> getTeachers(
      subjectID, categoryID, classID, UserModel comeUser) async {
    try {
      List<TeacherModel> comeList = await _userRepository.getTeachers(
          subjectID, categoryID, classID, comeUser);
      return comeList;
    } catch (e) {
      print("hata var");
      return null;
    }
  }
}

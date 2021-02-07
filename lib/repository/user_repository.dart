import 'package:arika/model/category_model.dart';
import 'package:arika/model/class_model.dart';
import 'package:arika/model/subject_model.dart';
import 'package:arika/model/teacher_model.dart';
import 'package:arika/model/user_model.dart';
import 'package:arika/service/auth_service.dart';
import 'package:arika/service/data_service.dart';
import 'package:arika/service/locator.dart';
import 'package:arika/service/storage_service.dart';
import 'package:arika/service/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  AuthService _authService = locator<AuthService>();
  UserService _userService = locator<UserService>();
  DataService _dataService = locator<DataService>();

  StorageService _storageService = locator<StorageService>();

  List<UserModel> kullanicilarListesi = [];

  Future<User> signUp({name, email, password, who}) async {
    User user = await _authService.signUp(email: email, password: password);
    await _userService.saveUser(
        user: UserModel(email: email, name: name, id: user.uid, who: who));
    return user;
  }

  Future<User> currentUser() async {
    User user = await _authService.currentUser();
    if (user != null) {
      return user;
    } else {
      return null;
    }
  }

  Future<User> login(String email, String sifre) async {
    return await _authService.login(email, sifre);
  }

  Future<bool> signOut() async {
    return await _authService.signOut();
  }

  Future<User> signInWithGoogle() async {
    User user = await _authService.signInWithGoogle();
    if (await _userService.readUser(user.uid) == false) {
      await _userService.saveUser(
        user: UserModel(
          email: user.email,
          id: user.uid,
          name: user.displayName,
        ),
      );
      return user;
    } else {
      return user;
    }
  }

  Future forgotPassword(String email) async {
    await _authService.forgotPassword(email);
  }

  Future<bool> validateCurrentPassword(
      String oldPassword, String newPassword, User buUser) async {
    return await _authService.validateCurrentPassword(
        oldPassword, newPassword, buUser);
  }

  Future uploadVideo(
      {String workIndex,
      String classIndex,
      String subjectIndex,
      String description,
      file,
      comeUser}) async {
    String url = await _storageService.uploadVideo(file: file);
    if (url != null) {
      await _userService.uploadVideo(
          url: url,
          workIndex: workIndex,
          classIndex: classIndex,
          subjectIndex: subjectIndex,
          description: description,
          comeUser: comeUser);
    }
  }

  Future<List<CategoryModel>> getCategories() async {
    return await _dataService.getCategories();
  }

  Future<List<SubjectModel>> getSubjects(categoryID, classID) async {
    return await _dataService.getSubjects(categoryID, classID);
  }

  Future<List<ClassModel>> getClass(String id) async {
    return await _dataService.getClass(id);
  }

  Future<List<TeacherModel>> getTeachers(
      subjectID, categoryID, classID, UserModel comeUser) async {
    return await _dataService.getTeachers(
        subjectID, categoryID, classID, comeUser);
  }
}

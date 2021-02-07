import 'package:arika/model/user_model.dart';
import 'package:arika/repository/user_repository.dart';
import 'package:arika/service/locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum UserStatus { SUCCESS }

class UserProvider with ChangeNotifier {
  UserRepository _userRepository = locator<UserRepository>();
  UserModel _user;
  final FirebaseFirestore _firebaseDB = FirebaseFirestore.instance;

  UserStatus _userStatus;

  UserModel get user => _user;

  set user(UserModel value) {
    _user = value;
    notifyListeners();
  }

  UserProvider() {
    currentUser();
    notifyListeners();
  }

  bool isLoading = false;

  changeState(bool _isLoading) {
    isLoading = _isLoading;
    notifyListeners();
  }

  Future<UserModel> currentUser() async {
    try {
      User _user1 = await _userRepository.currentUser();
      if (_user1 != null) {
        DocumentSnapshot userDocSnapshot =
            await _firebaseDB.collection("users").doc(_user1.uid).get();
        user = UserModel.fromDoc(userDocSnapshot);
        notifyListeners();
        return user;
      } else {
        return null;
      }
    } catch (e) {
      print('User Store getCurrentUser error: $e');
      return null;
    }
  }

  Future uploadVideo(
      {String workIndex,
      String classIndex,
      String subjectIndex,
      file,
      description,
      comeUser}) async {
    try {
      changeState(true);
      _userStatus = UserStatus.SUCCESS;
      await _userRepository.uploadVideo(
          workIndex: workIndex,
          classIndex: classIndex,
          subjectIndex: subjectIndex,
          description: description,
          file: file,
          comeUser: comeUser);
    } catch (e) {
      _userStatus = null;
      return e;
    } finally {
      changeState(false);
    }
    return _userStatus;
  }
}
/*

  Future createUserWithEmailandPassword(email, sifre, adSoyad) async {
    try {
      user = await _userRepository.createUserWithEmailandPassword(
          email, sifre, adSoyad);
      return user;
    } catch (e) {
      return null;
    }
  }

  Future currentUser() async {
    print("curent user");
    try {
      user = await _userRepository.currentUser();
      if (user != null) {
        print("içinde dönüyor");
        return user;
      }
    } catch (e) {
      print("UserModel currentUser bölümünde hata var $e");
      return null;
    }
  }

  Future signInWithEmailandPassword(
      String email, String sifre, BuildContext context1) async {
    try {
      notifyListeners();
      user = await _userRepository.signInWithEmailandPassword(email, sifre);
      if (user != null) {
        Navigator.of(context1).push(MaterialPageRoute(
          builder: (context) => BottomNavigationBars(
            currentTab1: 0,
          ),
        ));
        return user;
      }
    } on FirebaseAuthException catch (e) {
      if (e.toString() ==
          "[firebase_auth/ınvalıd-emaıl] The email address is badly formatted.") {
        ScaffoldMessenger.of(context1).showSnackBar(SnackBar(
          content: Text("Bu email adresi geçersiz formatta"),
          duration: Duration(seconds: 1),
        ));
      } else if (e.toString() ==
          "[firebase_auth/emaıl-already-ın-use] The email address is already in use by another account.") {
        ScaffoldMessenger.of(context1).showSnackBar(SnackBar(
          content: Text("Bu email adresi zaten kullanımda"),
          duration: Duration(seconds: 1),
        ));
      } else {
        ScaffoldMessenger.of(context1).showSnackBar(SnackBar(
          content: Text("Böyle bir hesap bulunmamaktadır"),
          duration: Duration(seconds: 1),
        ));
      }
    }
  }

  Future<bool> signOut() async {
    try {
      await _userRepository.signOut();
      user = null;
      return true;
    } catch (e) {
      print("UserModel signOut bölümünde hata var $e");
      return false;
    }
  }

  Future<User1> signInWithGoogle() async {
    try {
      user = await _userRepository.signInWithGoogle();
      return _user;
    } catch (e) {
      print("hata var ${e.toString()}");
      return null;
    }
  }
 */

import 'package:arika/exception_handlers/auth_exception_handler.dart';
import 'package:arika/repository/user_repository.dart';
import 'package:arika/services/locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum VerifyState { WAITING_FOR_VERIFY, VERIFIED }

class AuthProvider with ChangeNotifier {
  UserRepository _userRepository = locator<UserRepository>();

  AuthProvider() {
    currentUser();
    notifyListeners();
  }

  AuthResultStatus authStatus;
  AuthResultStatus accountAuthStatus;

  VerifyState verifyState = VerifyState.WAITING_FOR_VERIFY;
  List<String> signInMethods = [];

  bool isLoading = false;

  User thisUser;

  setUser(User _user) {
    thisUser = _user;
    notifyListeners();
  }

  changeState(bool _isLoading) {
    isLoading = _isLoading;
    notifyListeners();
  }

  currentUser() async {
    try {
      changeState(true);
      thisUser = await _userRepository.currentUser();
      return currentUser;
    } catch (e) {
      print('AuthStore getUser Error: $e');
      return null;
    } finally {
      changeState(false);
    }
  }

  Future signOut() async {
    try {
      changeState(true);
      await _userRepository.signOut();
      thisUser = null;
      authStatus = AuthResultStatus.successful;
      notifyListeners();
    } catch (e) {
      print("error in sign out");
      authStatus = AuthExceptionHandler.handleException(e);
    } finally {
      changeState(false);
    }
    return authStatus;
  }

  Future<AuthResultStatus> login(
      {@required String email, @required String password}) async {
    changeState(true);
    try {
      User user = await _userRepository.login(email, password);
      if (user != null) {
        print('AuthStore logIn user verified');
        thisUser = user;
        authStatus = AuthResultStatus.successful;
      }
    } on FirebaseAuthException catch (e) {
      print('Auth Store Login Error: $e');
      authStatus = AuthExceptionHandler.handleException(e);
    } finally {
      changeState(false);
    }
    return authStatus;
  }

  Future<AuthResultStatus> loginWithGoogle() async {
    try {
      authStatus = null;
      changeState(true);
      User user = await _userRepository.signInWithGoogle();
      if (user != null) {
        print('AuthStore user Logged with loginWithGoogle');
        authStatus = AuthResultStatus.successful;
        thisUser = user;
        changeState(false);
      } else {
        print('AuthStore loginWithGoogle user null');
        authStatus = AuthResultStatus.abortedByUser;
        changeState(false);
      }
    } catch (e) {
      print('Auth Store loginWithGoogle Error: $e');
      authStatus = AuthResultStatus.abortedByUser;
      changeState(false);
    }
    return authStatus;
  }

  Future<AuthResultStatus> signUp(
      {@required String name,
      @required String email,
      @required String password}) async {
    try {
      changeState(true);
      User user = await _userRepository.signUp(
          name: name, email: email, password: password);
      if (user != null) {
        authStatus = AuthResultStatus.successful;
        thisUser = user;
        notifyListeners();
      } else {
        print('AuthStore signUp user null');
      }
    } on FirebaseAuthException catch (e) {
      print('Auth Store signUp Error: $e');
      authStatus = AuthExceptionHandler.handleException(e);
    } finally {
      changeState(false);
    }
    return authStatus;
  }

  Future forgotPassword(String email) async {
    try {
      changeState(true);
      await _userRepository.forgotPassword(email);
      authStatus = AuthResultStatus.successful;
      changeState(false);
    } on FirebaseAuthException catch (e) {
      authStatus = AuthExceptionHandler.handleException(e);
      changeState(false);
    }
    return authStatus;
  }

  Future validateCurrentPassword(
      String oldPassword, String newPassword, User buUser) async {
    try {
      changeState(true);
      await _userRepository
          .validateCurrentPassword(oldPassword, newPassword, buUser)
          .then((value) {
        if (value == true) {
          print("başarılı");
          authStatus = AuthResultStatus.successful;
          changeState(false);
        } else {
          print("başarısız");
          authStatus = AuthResultStatus.wrongPassword;
          changeState(false);
        }
      });
    } on FirebaseAuthException catch (e) {
      print("başarısız 2");
      authStatus = AuthExceptionHandler.handleException(e);
      changeState(false);
    }
    return authStatus;
  }
}

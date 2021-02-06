import 'package:arika/model/user_model.dart';
import 'package:arika/service/auth_service.dart';
import 'package:arika/service/locator.dart';
import 'package:arika/service/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  AuthService _authService = locator<AuthService>();
  UserService _userService = locator<UserService>();

  //FirebaseStorageService _firebaseStorageService = locator<FirebaseStorageService>();

  List<UserModel> kullanicilarListesi = [];

  Future<User> signUp({name, email, password}) async {
    User user = await _authService.signUp(email: email, password: password);
    await _userService.saveUser(
      UserModel(
        email: email,
        name: name,
      ),
    );
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
        UserModel(
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
}

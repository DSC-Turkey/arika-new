import 'package:arika/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final FirebaseFirestore _firebaseDB = FirebaseFirestore.instance;

  Future saveUser(UserModel user) async {
    try {
      await _firebaseDB.collection("users").doc(user.id).set(user.toMap());
      print("firebase_db_service kullanıcı başarıyla kaydedildi");
    } catch (e) {
      print("firebase_db_service kullanıcı kaydedilmesi başarısız $e");
    }
  }

  Future readUser(String userID) async {
    try {
      DocumentSnapshot _okunanUser =
          await _firebaseDB.collection("users").doc(userID).get();
      print("firebase_db_service kullanıcı okunması başarılı");
      if (_okunanUser.data() != null) {
        return true;
      } else
        return false;
    } catch (e) {
      print("firebase_db_service kullanıcı okunması başarısız $e");
    }
  }
}

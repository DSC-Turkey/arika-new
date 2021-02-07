import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String name;
  String email;
  bool who;

  UserModel({this.email, this.id, this.name, this.who});

  Map<String, dynamic> toMap() {
    return {
      'userID': id,
      'userName': name,
      'email': email,
      'who': who,
    };
  }

  UserModel.fromMap(Map<String, dynamic> map)
      : id = map['userID'],
        name = map['userName'],
        who = map['who'],
        email = map['email'];

  factory UserModel.fromDoc(DocumentSnapshot source) =>
      UserModel.fromMap(source.data());
}

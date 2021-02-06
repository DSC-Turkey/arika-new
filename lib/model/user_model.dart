import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String name;
  String email;

  UserModel({this.email, this.id, this.name});

  Map<String, dynamic> toMap() {
    return {
      'userID': id,
      'userName': name,
      'email': email,
    };
  }

  UserModel.fromMap(Map<String, dynamic> map)
      : id = map['userID'],
        name = map['userName'],
        email = map['email'];

  factory UserModel.fromDoc(DocumentSnapshot source) =>
      UserModel.fromMap(source.data());
}

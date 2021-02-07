import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final firestore = FirebaseFirestore.instance;
final storageRef = FirebaseStorage.instance.ref();
CollectionReference usersRef = firestore.collection('users');
final activitiesRef = firestore.collection('activities');
final transactionsRef = firestore.collection('transactions');
final invitationsRef = firestore.collection('invitations');
final documentReference = firestore.collection("tokens");
final wishListReference = firestore.collection("wish_list");
final categoryReference = firestore.collection("categories");
final commentsReference = firestore.collection("comments");

//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class Db{
//
//   CollectionReference users = FirebaseFirestore.instance.collection('users');
//
//   Future<void> addUser(data, context) async {
//     final userId = FirebaseAuth.instance.currentUser!.uid;
//     await users
//         .doc('userID')
//         .set(data)
//         .then((value) => print("User Added"))
//         .catchError((error) => print("Use not added"));
//   }
//
//
// }
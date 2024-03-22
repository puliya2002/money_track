//
//
//
//
// import 'dart:html';
//
// class CategoryModel {
//   final String id;
//   final String name;
//   final String color;
//   final String icon;
//
//   CategoryModel({
//       required this.id,
//       required this.name,
//       required this.color,
//       required this.icon
//       });
//
//
//
// //   factory Category.fromJson(Map<String, dynamic> json) {
// //     return Category(
// //       id: json['id'] ?? '',
// //       name: json['name'] ?? '',
// //       color: json['color'] ?? '',
// //       icon: json['icon'] ?? '',
// //     );
// //   }
// // }
// factory CategoryModel.fromSnapshot(documentSnapshot<Map<String, dynamic>>){
//   final data = document.data()!;
//   return CategoryModel(id: document.id, name: data["name"], color: data["color"], icon: data["icon"]);
//   }
//   }




// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class GetCategories extends StatelessWidget {
//
//   final String documentId;
//   GetCategories({required this.documentId});
//
//   @override
//   Widget build(BuildContext context) {
//     CollectionReference category = FirebaseFirestore.instance.collection('category');
//
//     return FutureBuilder(
//         future: category.doc(documentId).get(),
//         builder: ((context, snapshot){
//           if(snapshot.connectionState == ConnectionState.done){
//             Map<String, dynamic> data =
//                 snapshot.data!.data() as Map<String, dynamic>;
//             return Text('Name: ${data['name']}');
//           }
//           return Text('loading..');
//
//     }),
//     );
//   }
// }


import 'dart:convert';

GetCategories getCategoriesFromJson(String str) => GetCategories.fromJson(json.decode(str));

String getCategoriesToJson(GetCategories data) => json.encode(data.toJson());

class GetCategories {
  String id;
  String name;
  String color;
  String icon;

  GetCategories({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
  });

  factory GetCategories.fromJson(Map<String, dynamic> json) => GetCategories(
    id: json["id"],
    name: json["name"],
    color: json["color"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "color": color,
    "icon": icon,
  };
}

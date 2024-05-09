// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../model/category_model.dart';
//
//
// class CategoryService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   Future<List<Category>> getCategories() async {
//     List<Category> categories = [];
//
//     try {
//       QuerySnapshot querySnapshot = await _firestore.collection('categories').get();
//       querySnapshot.docs.forEach((doc) {
//         categories.add(Category.fromJson({
//           'id': doc.id,
//           'name': doc['name'],
//           'color': doc['color'],
//           'icon': doc['icon'],
//         }));
//       });
//     } catch (e) {
//       print("Error fetching categories: $e");
//     }
//
//     return categories;
//   }
// }
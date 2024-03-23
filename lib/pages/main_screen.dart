import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:money_track/model/category_model.dart';

import '../service/category_service.dart';
import '../widgets/transactions_card.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key, required this.userID});
  final String userID;
  final Stream<DocumentSnapshot> _usersStream = FirebaseFirestore.instance.collection('users').doc().snapshots();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder<DocumentSnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Text("Document does now exist");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        var data = snapshot.data!.data();

        return Cards();


      },


    );



  }




  @override
  State<MainScreen> createState() => _MainScreenState();



  
}







class _MainScreenState extends State<MainScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  // //////////////////////////////////////////latest start
  //
  // List<GetCategories> categoryItems = [];
  //
  // @override
  // void initState() {
  //   fetchRecords();
  //   super.initState();
  // }
  //
  // fetchRecords() async {
  //   try {
  //     var records =
  //         await FirebaseFirestore.instance.collection('category').get();
  //     mapRecords(records);
  //   } catch (e) {
  //     print('Error fetching records: $e');
  //   }
  // }
  //
  // mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
  //   var _list = records.docs
  //       .map((category) => GetCategories(
  //             id: category.id,
  //             name: category['name'],
  //             color: category['color'],
  //             icon: category['icon'],
  //           ))
  //       .toList();
  //
  //   setState(() {
  //     categoryItems = _list;
  //   });
  // }
  // //////////////////////////////////////////////////////////latest end

  // //document IDs
  // List<String> docIDs = [];
  //
  // //get docIDs
  // Future getDocId() async {
  //   await FirebaseFirestore.instance
  //       .collection('category')
  //       .get()
  //       .then((snapshot) => snapshot.docs.forEach((document) {
  //             print(document.reference);
  //             docIDs.add(document.reference.id);
  //           }));
  // }





  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 10),
        child: Column(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Row(
            //       children: [
            //         Column(
            //           children: [
            //             Stack(
            //               alignment: Alignment.center,
            //               children: [
            //                 Container(
            //                   width: 30,
            //                   height: 30,
            //                   decoration: const BoxDecoration(
            //                     shape: BoxShape.circle,
            //                     color: Colors.yellow,
            //                   ),
            //                 ),
            //                 Icon(
            //                   CupertinoIcons.person_fill,
            //                   color: Colors.black,
            //                   size: 18,
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ),
            //         const SizedBox(width: 8),
            //         Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text(
            //               "Welcome!",
            //               style: TextStyle(
            //                   color: Theme.of(context).colorScheme.onBackground,
            //                   fontWeight: FontWeight.w400,
            //                   fontSize: 10),
            //             ),
            //             Text(
            //               user.email!,
            //               style: TextStyle(
            //                   color: Theme.of(context).colorScheme.onBackground,
            //                   fontWeight: FontWeight.w600,
            //                   fontSize: 14),
            //             ),
            //           ],
            //         ),
            //       ],
            //     ),
            //     Row(
            //       children: [
            //         IconButton(
            //           onPressed: () {
            //             FirebaseAuth.instance.signOut();
            //           },
            //           icon: const Icon(
            //               Icons.logout
            //           ),
            //         ),
            //         IconButton(
            //           onPressed: () {},
            //           icon: const Icon(
            //               Icons.menu_rounded
            //           ),
            //         ),
            //
            //       ],
            //     )
            //   ],
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.secondary,
                      Theme.of(context).colorScheme.primary,
                    ],
                    transform: const GradientRotation(pi / 3),
                  ),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 20,
                        color: Theme.of(context)
                            .colorScheme
                            .shadow
                            .withOpacity(0.4),
                        offset: Offset(2, 1))
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        children: [
                          Text(
                            "Balance",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "LKR",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Text(
                                "1500.00",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromARGB(226, 255, 255, 255),
                                    ),
                                  ),
                                  const Icon(
                                    CupertinoIcons.arrow_down,
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Expenses",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "150000.00",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromARGB(226, 255, 255, 255),
                                    ),
                                  ),
                                  const Icon(
                                    CupertinoIcons.arrow_up,
                                    color: Colors.green,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Expenses",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "150000.00",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Row(
                        children: [],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Transactions",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 65,
                            height: 23,
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                borderRadius: BorderRadius.circular(100)),
                          ),
                          Text(
                            "Income",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackground
                                  .withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 79,
                            height: 23,
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                borderRadius: BorderRadius.circular(100)),
                          ),
                          Text(
                            "Expenses",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackground
                                  .withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),

            TransactionsCard()
          ],
        ),
      ),
    );
  }
}

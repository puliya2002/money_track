import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:money_track/model/category_model.dart';
import 'package:provider/provider.dart';

import '../service/category_service.dart';
import '../provider/currency_provider.dart';
import '../widgets/hero_card.dart';
import '../widgets/transactions_card.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});


  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final user = FirebaseAuth.instance.currentUser!;




  @override

  Widget build(BuildContext context) {
    String currency = Provider.of<CurrencyProvider>(context).selectedCurrency;
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
              child: HeroCard(UserId: user.uid, currency: currency,)
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

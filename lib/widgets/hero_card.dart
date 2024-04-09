import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../model/transaction_model.dart';

class HeroCard extends StatelessWidget {
  HeroCard({
    super.key,
    required this.month,
    required this.currency,
  });

  final userId = FirebaseAuth.instance.currentUser!.uid;
  final String month;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection("transactions")
          .where('monthyear', isEqualTo: month)
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Container(
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
                    color:
                    Theme.of(context).colorScheme.shadow.withOpacity(0.4),
                    offset: Offset(2, 1))
              ],
            ),
            child: Center(
              child: Text("Something went wrong"),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
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
                    color:
                    Theme.of(context).colorScheme.shadow.withOpacity(0.4),
                    offset: Offset(2, 1))
              ],
            ),
            child: Center(
              child: Text("Loading"),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Container(
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
                    color:
                    Theme.of(context).colorScheme.shadow.withOpacity(0.4),
                    offset: Offset(2, 1))
              ],
            ),
            child: Center(
              child: Text("No transactions found in this month"),
            ),
          );
        }

        var data = snapshot.data!.docs;
        double totalAmount = 0.0;
        double totalCredit = 0.0;
        double totalDebit = 0.0; // Initialize total amount variable
        for (var transaction in data) {
          // Calculate total amount
          totalAmount += transaction['type'] == 'Credit'
              ? transaction['amount']
              : -transaction['amount'];
        }

        for (var transactionCredit in data) {
          // Calculate total amount
          totalCredit += transactionCredit['type'] == 'Credit'
              ? transactionCredit['amount']
              : 0;
        }
        for (var transactionDebit in data) {
          // Calculate total amount
          totalDebit += transactionDebit['type'] == 'Debit'
              ? transactionDebit['amount']
              : 0;
        }

        return
            Cards(
              currency: currency,
              UserId: userId,
              data: {
                'totalAmount': totalAmount,
                'totalCredit': totalCredit,
                'totalDebit': totalDebit,
              },

            );




      },
    );
  }
}




class Cards extends StatefulWidget {
  const Cards(
      {super.key,
      required this.data,
      required this.currency,
      required this.UserId});
  final String currency;
  final String UserId;
  final Map data;

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              color: Theme.of(context).colorScheme.shadow.withOpacity(0.4),
              offset: Offset(2, 1))
        ],
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 18, right: 18, bottom: 15, top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Center(
                    child: Text(
                      "Balance",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
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
                          widget.currency,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Text(
                      "${widget.data['totalAmount'].toStringAsFixed(2)}",
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
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red.shade50,
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
                    Column(
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
                        Row(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  widget.currency,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Text(
                              "${widget.data['totalDebit'].toStringAsFixed(2)}",
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
                Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green.shade50,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Incomes",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  widget.currency,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Text(
                              "${widget.data['totalCredit'].toStringAsFixed(2)}",
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
              ],
            ),
            const Row(
              children: [],
            ),
          ],
        ),
      ),
    );
  }
}

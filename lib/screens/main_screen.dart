import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'package:money_track/model/category_model.dart';
import 'package:money_track/screens/pie_chart_screen.dart';
import 'package:provider/provider.dart';

import '../service/category_service.dart';
import '../provider/currency_provider.dart';
import '../widgets/hero_card.dart';
import '../widgets/recent_transactions_card.dart';



class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  late String selectedMonth;

  @override
  void initState() {
    super.initState();
    selectedMonth = DateFormat('MMM y').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> _buildMonthDropdownItems() {
      List<String> allMonths = [];
      List<int> years = [];

      DateTime currentDate = DateTime.now();
      int currentYear = currentDate.year;

      // Add all months for all years
      for (int year = currentYear; year >= currentYear - 10; year--) {
        for (int month = 12; month >= 1; month--) {
          allMonths
              .add('${DateFormat('MMM').format(DateTime(year, month))} $year');
        }
        years.add(year);
      }

      return allMonths.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList();
    }

    String currency = Provider.of<CurrencyProvider>(context).selectedCurrency;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 10),
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, '/pie');

                    },
                    child: HeroCard(
                      currency: currency,
                      month: selectedMonth,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DropdownButton<String>(
                          value: selectedMonth,
                          style: TextStyle(fontSize: 15),
                          icon: Icon(Icons.arrow_drop_down_sharp,
                              color: Colors.white),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedMonth = newValue!;
                            });
                          },
                          dropdownColor: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(20),
                          items: _buildMonthDropdownItems()),
                    ],
                  ),
                ),
              ],
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
                      "Recent Transactions",
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
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 65,
                          height: 21,
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
                    // const SizedBox(
                    //   width: 5,
                    // ),
                    // Text(
                    //   "&",
                    //   style: TextStyle(
                    //     fontSize: 14,
                    //     fontWeight: FontWeight.w600,
                    //     color: Theme.of(context)
                    //         .colorScheme
                    //         .onBackground
                    //         .withOpacity(0.3),
                    //   ),
                    //
                    // ),
                    const SizedBox(
                      width: 5,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 79,
                          height: 21,
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
                                .withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            TransactionsCard(
              month: selectedMonth,
            )
          ],
        ),
      ),
    );
  }
}

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

        return Cards(
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

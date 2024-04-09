import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/transaction_card_model.dart';

class StatesTransactionList extends StatelessWidget {
  StatesTransactionList({
    Key? key,
    required this.category,
    required this.type,
    required this.monthYear,
  }) : super(key: key);

  final userId = FirebaseAuth.instance.currentUser!.uid;

  final String category;
  final String type;
  final String monthYear;

  @override
  Widget build(BuildContext context) {
    Query query = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection("transactions")
        .orderBy('timestamp', descending: false)
        .where('type', isEqualTo: type)
        .where('monthyear', isEqualTo: monthYear);

    if (category != 'All') {
      query = query.where('category', isEqualTo: category);
    }

    return FutureBuilder<QuerySnapshot>(
      future: query.limit(150).get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text("No transactions found"),
          );
        }

        var data = snapshot.data!.docs;
        double totalAmount = 0.0; // Initialize total amount variable
        for (var transaction in data) {
          // Calculate total amount
          totalAmount += transaction['type'] == 'Credit'
              ? transaction['amount']
              : -transaction['amount'];
        }
        return Expanded(
          child: Column(
            children: [
              Expanded(
                child: DefaultTabController(
                  length: 20,
                  child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      var cardData = data[index];
                      return TransactionModel(data: cardData);
                    },
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  color: Colors.transparent, // Change color as per your design
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(
                    '${totalAmount.toStringAsFixed(2)}', // Display total amount
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

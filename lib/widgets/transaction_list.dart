import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/transaction_model.dart';

class TransactionList extends StatelessWidget {
  TransactionList({
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
        return Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                var cardData = data[index];
                return TransactionModel(data: cardData);
              },
            ),
            SizedBox(height: 10),
            Text(
              'Total: ${totalAmount.toStringAsFixed(2)}', // Display total amount
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        );
      },
    );
  }
}

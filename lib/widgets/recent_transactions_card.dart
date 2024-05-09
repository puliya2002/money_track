import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_track/data/icons_list_expense.dart';
import 'package:money_track/model/transaction_card_model.dart';

class TransactionsCard extends StatelessWidget {
  TransactionsCard({super.key, required this.month});
  final String month;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RecentTransactionList(
        month: month,
      ),
    );
  }
}

class RecentTransactionList extends StatelessWidget {
  RecentTransactionList({
    super.key,
    required this.month,
  });

  final userId = FirebaseAuth.instance.currentUser!.uid;
  final String month;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection("transactions")
          .where('monthyear', isEqualTo: month)
          .orderBy('timestamp', descending: true)
          // .limit(30)
          .snapshots(),
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
        return ListView.builder(
          shrinkWrap: true,
          // physics: NeverScrollableScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (context, index) {
            var cardData = data[index];
            return TransactionModel(data: cardData);
          },
        );
      },
    );
  }
}

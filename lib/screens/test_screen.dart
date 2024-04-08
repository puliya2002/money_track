import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Test extends StatefulWidget {
  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction List'),
      ),
      body: TransactionListWidget(),
    );
  }
}

class TransactionListWidget extends StatefulWidget {
  @override
  _TransactionListWidgetState createState() => _TransactionListWidgetState();
}

class _TransactionListWidgetState extends State<TransactionListWidget> {
  late String selectedMonth;

  @override
  void initState() {
    super.initState();
    selectedMonth = DateFormat('MMM y').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton<String>(
          value: selectedMonth,
          onChanged: (String? newValue) {
            setState(() {
              selectedMonth = newValue!;
            });
          },
          items: _buildMonthDropdownItems(),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('transactions')
                .where('monthyear', isEqualTo: selectedMonth)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }

              final List<DocumentSnapshot> documents = snapshot.data!.docs;

              return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  final transaction =
                  documents[index].data() as Map<String, dynamic>;
                  final String category = transaction['category'];

                  return ListTile(
                    title: Text(transaction['title']),
                    subtitle: Text('Amount: ${transaction['amount']}'),
                    trailing: Text('Category: $category'),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> _buildMonthDropdownItems() {
    List<String> allMonths = [];
    List<int> years = [];

    DateTime currentDate = DateTime.now();
    int currentYear = currentDate.year;

    // Add all months for all years
    for (int year = currentYear; year >= currentYear - 10; year--) {
      for (int month = 12; month >= 1; month--) {
        allMonths.add('${DateFormat('MMM').format(DateTime(year, month))} $year');
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
}
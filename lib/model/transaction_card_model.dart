import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../data/icons_list_expense.dart';
import '../data/icons_list_income.dart';
import '../provider/currency_provider.dart';

class TransactionModel extends StatefulWidget {
  TransactionModel({
    super.key,
    required this.data,
  });
  final dynamic data;

  @override
  State<TransactionModel> createState() => _TransactionModelState();
}

class _TransactionModelState extends State<TransactionModel> {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  var appIconsIncome = AppIconsIncome();

  var appIcons = AppIconsExpense();

  String title = '';
  double amount = 0.0;

  @override
  void initState() {
    super.initState();
    title = widget.data['title'];
    amount = widget.data['amount'];
  }

  @override
  Widget build(BuildContext context) {
    String currency = Provider.of<CurrencyProvider>(context).selectedCurrency;

    var addedDate = (widget.data['timestamp'] as Timestamp).toDate();
    String formatDateTime(DateTime dateTime) {
      return DateFormat.yMMMMd().add_jm().format(dateTime);
    }
    // String formatedDate = DateFormat('d MMM hh:mm a').format(date);

    return Dismissible(
      key: Key(widget.data['id']),
      direction: DismissDirection.horizontal,
      background: Container(
        color: Colors.green,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Icon(Icons.edit, color: Colors.white),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {

        if (direction == DismissDirection.startToEnd) {
          return await showDialog(
            context: context,
            builder: (BuildContext context) {
              // String title = widget.data['title'];
              // double amount = widget.data['amount'];
              return AlertDialog(
                title: Text("Edit Transaction"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      initialValue: title,
                      decoration: InputDecoration(labelText: 'Title'),
                      onChanged: (value) {
                        setState(() {
                          title = value;
                        });
                      },
                    ),
                    TextFormField(
                      initialValue: amount.toString(),
                      decoration: InputDecoration(labelText: 'Amount'),
                      onChanged: (value) {
                        setState(() {
                          amount = double.tryParse(value) ?? amount;
                        });
                      },
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () {

                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(userId)
                          .collection("transactions")
                          .doc(widget.data['id'])
                          .update({'title': title, 'amount': amount})
                          .then((_) {

                        Navigator.of(context).pop(false);
                      })
                          .catchError((error) {
                        print("Failed to update transaction: $error");

                      });
                    },
                    child: Text("Save"),
                  ),
                ],
              );
            },
          );
          return false;
        }
        // Continue to delete


        else if (direction == DismissDirection.endToStart) {
          // Show AlertDialog for confirmation
          return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Delete Transaction"),
                content: Text(
                    "Are you sure you want to delete this transaction?"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(userId)
                          .collection("transactions")
                          .doc(widget.data['id'])
                          .delete()
                          .then((value) => print("Transaction deleted"))
                          .catchError((error) =>
                          print("Failed to delete transaction: $error"));
                      Navigator.of(context).pop(
                          true); // Return true if deletion is confirmed
                    },
                    child: Text("Delete", style: TextStyle(color: Colors.red),),
                  ),
                ],
              );
            },
          );
        }

        },


      child: Padding(
        padding: const EdgeInsets.only(bottom: 18),
        child: Container(
          width: double.infinity,
          height: 75,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                  blurRadius: 16,
                  color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
                  offset: Offset(2, 4))
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 47,
                          height: 47,
                          decoration: BoxDecoration(
                            color: widget.data['type'] == 'Credit'
                                ? Colors.green.withOpacity(0.1)
                                : Colors.red.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                        ),
                        FaIcon(widget.data['type'] == 'Credit'?
                          appIconsIncome.getExpenseCategoryIcons("${widget.data['category']}")
                            : appIcons.getExpenseCategoryIcons("${widget.data['category']}")

            ,
                          color: widget.data['type'] == 'Credit'
                          ? Colors.green
                          : Colors.red,
                          size: 17,
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.data['title']}",
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackground
                                  .withOpacity(0.9),
                              fontWeight: FontWeight.w800,
                              fontSize: 17),
                        ),
                        Text(
                          formatDateTime(addedDate),
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackground
                                  .withOpacity(0.6),
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "${widget.data['type'] == 'Credit' ? '+' : '-'} $currency ${widget.data['amount'].toStringAsFixed(2)}",
                          style: TextStyle(
                              // color: Theme.of(context).colorScheme.onBackground.withOpacity(0.9),
                              color: widget.data['type'] == 'Credit'
                                  ? Colors.green
                                  : Colors.red,

                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                        Text(
                          "$currency ${widget.data['remainingAmount'].toStringAsFixed(2)}",
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackground
                                  .withOpacity(0.6),
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

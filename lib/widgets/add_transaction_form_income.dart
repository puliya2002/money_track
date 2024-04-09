import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_track/widgets/category_dropdown_income.dart';
import 'package:uuid/uuid.dart';

import '../utils/app_validator.dart';
import 'category_dropdown.dart';

class AddTransactionFormIncome extends StatefulWidget {
  const AddTransactionFormIncome({super.key});

  @override
  State<AddTransactionFormIncome> createState() => _AddTransactionFormIncomeState();
}

class _AddTransactionFormIncomeState extends State<AddTransactionFormIncome> {
  var type = "Credit"; // Changed initial value to 'Credit'
  var category = "Salary";
  var amountEditController = TextEditingController();
  var titleEditController = TextEditingController();
  var uid = Uuid();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var isLoader = false;
  var appValidator = AppValidator();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoader = true;
      });

      setState(() {
        isLoader = false;
      });
      final user = FirebaseAuth.instance.currentUser;

      var amount = double.parse(amountEditController.text);
      DateTime date = DateTime.now();

      var id = uid.v4();
      String monthyear = DateFormat('MMM y').format(date);

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();

      double remainingAmount = userDoc['remainingAmount'].toDouble();
      double totalCredit = userDoc['totalCredit'].toDouble();
      double totalDebit = userDoc['totalDebit'].toDouble();

      if (type == 'Credit') {
        remainingAmount += amount;
        totalCredit += amount;
      } else {
        remainingAmount -= amount;
        totalDebit -= amount;
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({
        "remainingAmount": remainingAmount,
        "totalCredit": totalCredit,
        "totalDebit": totalDebit,
        "updatedAt": DateTime.now(),
      });

      var data = {
        "id": id,
        "title": titleEditController.text,
        "amount": amount,
        "type": type,
        "timestamp": DateTime.now(),
        "totalCredit": totalCredit,
        "totalDebit": totalDebit,
        "remainingAmount": remainingAmount,
        "monthyear": monthyear,
        "category": category,
      };

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection("transactions")
          .doc(id)
          .set(data);

      Navigator.pop(context);

      setState(() {
        isLoader = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: titleEditController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: appValidator.isEmptyCheck,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextFormField(
              controller: amountEditController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: appValidator.isEmptyCheck,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            CtegoryDropDownIncome(
              cattype: category,
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    category = value;
                  });
                }
              },
            ),
            // DropdownButtonFormField(
            //   value: 'Credit', // Changed initial value to 'Credit'
            //   items: [
            //     DropdownMenuItem(
            //       child: Text('Income'),
            //       value: 'Credit',
            //     ),
            //     // DropdownMenuItem(
            //     //   child: Text('Expense'),
            //     //   value: 'Debit',
            //     // ),
            //   ],
            //   onChanged: (value) {
            //     if (value != null) {
            //       setState(() {
            //         type = value;
            //       });
            //     }
            //   },
            // ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),// Change this color to the desired background color.
                ),

                onPressed: () {
                  if (isLoader == false) {
                    _submitForm();
                  }
                },
                child: isLoader
                    ? Center(child: CircularProgressIndicator())
                    : Text('Add Income', style: TextStyle(fontSize: 15),),)
          ],
        ),
      ),
    );
  }
}

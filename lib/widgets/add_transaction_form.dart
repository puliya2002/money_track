import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_validator.dart';
import 'category_dropdown.dart';

class AddTransactionForm extends StatefulWidget {
  const AddTransactionForm({super.key});

  @override
  State<AddTransactionForm> createState() => _AddTransactionFormState();
}

class _AddTransactionFormState extends State<AddTransactionForm> {
  var type = "Credit"; // Changed initial value to 'Credit'
  var category = "Others";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var isLoader = false;
  var appValidator = AppValidator();

  Future<void> _submitForm() async{
    if (_formKey.currentState!.validate()){
      setState(() {
        isLoader = true;
      });

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
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: appValidator.isEmptyCheck,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: appValidator.isEmptyCheck,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            CtegoryDropDown(
              cattype: category,
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    category = value;
                  });
                }
              },
            ),
            DropdownButtonFormField(
              value: 'Credit', // Changed initial value to 'Credit'
              items: [
                DropdownMenuItem(
                  child: Text('Credit'),
                  value: 'Credit',
                ),
                DropdownMenuItem(
                  child: Text('Debit'),
                  value: 'Debit',
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    type = value;
                  });
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: (){
              if(isLoader==false){
                _submitForm();
              }


            }, child:
            isLoader ? Center(child: CircularProgressIndicator()):
                Text('Add transaction'))
          ],
        ),
      ),
    );
  }
}


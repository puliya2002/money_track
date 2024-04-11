import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppIconsIncome {
  final List<Map<String,dynamic>> homeExpensesCategoriesIncome = [
    {
      "name" : "Salary",
      "icon" : FontAwesomeIcons.dollarSign,
    },

    {
      "name" : "Deposits",
      "icon" : FontAwesomeIcons.bank,
    },

    {
      "name" : "Savings",
      "icon" : FontAwesomeIcons.piggyBank,
    },


  ];

  IconData getExpenseCategoryIcons(String categoryName){
    final category = homeExpensesCategoriesIncome.firstWhere(
            (category) => category['name'] == categoryName,
        orElse: ()=> {'icon' : FontAwesomeIcons.dollarSign});
    return category['icon'];

  }
}
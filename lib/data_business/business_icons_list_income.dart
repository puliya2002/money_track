import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BusinessAppIconsIncome {
  final List<Map<String,dynamic>> homeExpensesCategoriesIncome = [
    {
      "name" : "Product Sales",
      "icon" : CupertinoIcons.money_dollar_circle_fill
    },

    {
      "name" : "Subscription Revenue",
      "icon" : FontAwesomeIcons.moneyBill,
    },

    {
      "name" : "Advertising Revenue",
      "icon" : FontAwesomeIcons.moneyBillTrendUp,
    },
    {
      "name" : "Interest Income",
      "icon" : FontAwesomeIcons.bank,
    },




  ];

  IconData getExpenseCategoryIcons(String categoryName){
    final category = homeExpensesCategoriesIncome.firstWhere(
            (category) => category['name'] == categoryName,
        orElse: ()=> {'icon' : FontAwesomeIcons.dollarSign});
    return category['icon'];

  }
}